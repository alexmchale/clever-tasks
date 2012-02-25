#import "Task.h"

@implementation Task

@dynamic name;
@dynamic due;
@dynamic frequency;
@dynamic completed;
@dynamic uuid;

- (void) toggleCompleted
{
    if (self.completed == nil)
        self.completed = [NSDate date];
    else
        self.completed = nil;
    
    [CTX save:nil];
}

- (void) save
{
    if (self.uuid == nil) self.uuid = [NSString generateUUID];
    if (![self isInserted]) [CTX insertObject:self];
    
    NSLog(@"uuid = %@", self.uuid);
    
    [CTX save:nil];
}

- (Task *) createNext
{
    if ([self frequencyType] == kFrequencyOnce) return nil;
    if ([self doesNextTaskExist]) return nil;
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:CTX];
    Task *task = [[Task alloc] initWithEntity:desc insertIntoManagedObjectContext:CTX];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    switch ([self frequencyType])
    {
        case kFrequencyOnce:
            assert(NO);
            break;
            
        case kFrequencyDaily:
            components.day = 1;
            break;
            
        case kFrequencyWeekly:
            components.week = 1;
            task.due = [NSDate dateWithTimeInterval:ONE_WEEK sinceDate:self.due];
            break;
            
        case kFrequencyMonthly:
            components.month = 1;
            break;
            
        case kFrequencyYearly:
            components.year = 1;
            break;
    }
    
    task.name = self.name;
    task.frequency = self.frequency;
    task.completed = nil;
    task.due = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.due options:0];
    task.uuid = self.uuid;
    
    [task save];
    
    return task;
}

- (FrequencyType) frequencyType
{
    return (FrequencyType) [self.frequency integerValue];
}

- (NSCalendarUnit)localNotificationRepeatInterval
{
    switch ([self frequencyType])
    {
        case kFrequencyOnce: return 0;
        case kFrequencyDaily: return NSDayCalendarUnit;
        case kFrequencyWeekly: return NSWeekCalendarUnit;
        case kFrequencyMonthly: return NSMonthCalendarUnit;
        case kFrequencyYearly: return NSYearCalendarUnit;
    }
}

- (NSString *) describeFrequency
{
    return [Task describeFrequency:[self frequencyType]];
}

+ (NSString *) describeFrequency:(FrequencyType)type
{
    NSString *frequencies[] = {
        @"Once",
        @"Daily",
        @"Weekly",
        @"Monthly",
        @"Yearly"
    };
    
    return frequencies[type];
}

- (BOOL) doesNextTaskExist
{
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"Task"];    
    NSPredicate *due = [NSPredicate predicateWithFormat:@"due > %@", self.due];
    NSPredicate *uuid = [NSPredicate predicateWithFormat:@"uuid = %@", self.uuid];
    NSArray *preds = [NSArray arrayWithObjects:due, uuid, nil];
    NSPredicate *pred = [NSCompoundPredicate andPredicateWithSubpredicates:preds];
    
    [req setPredicate:pred];    
    [req setIncludesSubentities:NO];
    
    return [CTX countForFetchRequest:req error:nil] > 0;
}

- (BOOL) scheduleable
{
    return ![self completed] && [self.due isAfter:[NSDate date]];
}

- (NSString *) describeTime
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];    
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setDateStyle:NSDateFormatterShortStyle];
    
    NSDate *date = self.completed ? self.completed : self.due;
    NSString *dateString = [df stringFromDate:date];
    NSTimeInterval delta = [date timeIntervalSinceNow];
    NSString *deltaString = [NSString stringFromTimeDelta:delta];
    NSString *mode = [self describeFrequency];
    
    if (delta < 0)
        return [NSString stringWithFormat:@"%@ - %@ ago (%@)", dateString, deltaString, mode];
    else
        return [NSString stringWithFormat:@"%@ - %@ away (%@)", dateString, deltaString, mode];
}

- (BOOL) isDueToday
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDate *today = [NSDate date];
    NSDateComponents *taskComps = [cal components:unitFlags fromDate:self.due];
    NSDateComponents *todayComps = [cal components:unitFlags fromDate:today];
    return [taskComps isEqual:todayComps];
}

+ (NSArray *) all
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"due" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSDate *recentDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    NSPredicate *completed = [NSPredicate predicateWithFormat:@"completed = NULL"];
    NSPredicate *recently = [NSPredicate predicateWithFormat:@"completed >= %@", recentDate];
    NSArray *predicates = [NSArray arrayWithObjects:completed, recently, nil];
    NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicates];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [CTX executeFetchRequest:request error:&error];
    
    if (error != nil)
    {
        [NSException raise:NSGenericException format:[error description]];
    }
    
    return results;
}

+ (NSArray *) scheduleable
{
    NSMutableArray *results = [NSMutableArray array];

    // Scan the list of 
    for (Task *task in [Task all]) {
        if (![task scheduleable])
            continue;
        
        NSInteger index = [results indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            Task *t0 = obj;
            return [t0.uuid isEqualToString:task.uuid];
        }];
        
        if (index == NSNotFound) {
            [results addObject:task];
        } else {
            Task *t0 = [results objectAtIndex:index];
            if ([task.due isBefore:t0.due]) {
                [results replaceObjectAtIndex:index withObject:task];
            }
        }
    }
    
    return results;
}

+ (void) scheduleLocalNotifications
{
    NSLog(@"scheduleable tasks = %@", [Task scheduleable]);
    
    for (Task *task in [Task scheduleable]) {
        UILocalNotification *n = [[UILocalNotification alloc] init];
        
        n.fireDate = task.due;
        n.timeZone = [NSTimeZone defaultTimeZone];
        n.repeatInterval = [task localNotificationRepeatInterval];
        n.soundName = UILocalNotificationDefaultSoundName;
        n.alertBody = task.name;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:n];
    }
}

@end

































