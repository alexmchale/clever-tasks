#import "Task.h"

@implementation Task

@dynamic name;
@dynamic due;
@dynamic frequency;

+ (NSArray *) all
{
    return [[CTX fetchObjectsForEntityName:@"Task" withPredicate:nil] allObjects];
}

@end
