#import "NSDate+NSDateCategory.h"

@implementation NSDate (NSDateCategory)

- (BOOL) isBefore:(NSDate *)date
{
    return [self compare:date] == NSOrderedAscending;
}

- (BOOL)isAfter:(NSDate *)date
{
    return [self compare:date] == NSOrderedDescending;
}

@end
