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

- (NSString *)describeFrequency
{
    NSString *frequencies[] = {
        @"once",
        @"daily",
        @"weekly",
        @"monthly",
        @"yearly"
    };
    
    return frequencies[[self frequencyType]];
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

@end
