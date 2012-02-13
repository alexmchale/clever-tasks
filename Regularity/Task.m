#import "Task.h"

@implementation Task

@dynamic name;
@dynamic due;
@dynamic frequency;
@dynamic completed;

- (void) markAsCompleted
{
    self.completed = [NSDate date];
    [CTX save:nil];
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
