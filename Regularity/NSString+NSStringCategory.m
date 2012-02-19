#import "NSString+NSStringCategory.h"

@implementation NSString (NSStringCategory)

// A technique of generating a UUID without needing any funky memory.
+ (NSString *) generateUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFUUIDBytes theBytes = CFUUIDGetUUIDBytes(theUUID);
    NSString *format = @"%02X%02X%02X%02X-%02X%02X-%02X%02X-%02X%02X-%02X%02X%02X%02X%02X%02X";
    
    NSString *uuid =
        [NSString stringWithFormat:format,
            theBytes.byte0, theBytes.byte1, theBytes.byte2, theBytes.byte3,
            theBytes.byte4, theBytes.byte5, theBytes.byte6, theBytes.byte7,
            theBytes.byte8, theBytes.byte9, theBytes.byte10, theBytes.byte11,
            theBytes.byte12, theBytes.byte13, theBytes.byte14, theBytes.byte15];
    
    CFRelease(theUUID);
    
    return uuid;
}

+ (NSString *) stringFromTimeDelta:(NSTimeInterval)delta
{
    double d = fabs(delta);
    NSUInteger count;
    NSString *label;
    
    if (d < ONE_HOUR) {
        count = d / ONE_MINUTE;
        label = @"minute";
    } else if (d < ONE_DAY) {
        count = d / ONE_HOUR;
        label = @"hour";
    } else if (d < THIRTY_DAYS) {
        count = d / ONE_DAY;
        label = @"day";
    } else if (d < ONE_YEAR) {
        count = d / THIRTY_DAYS;
        label = @"month";
    } else {
        count = d / ONE_YEAR;
        label = @"year";
    }
    
    if (count == 1)
        return [NSString stringWithFormat:@"%d %@", count, label];
    else
        return [NSString stringWithFormat:@"%d %@s", count, label];
}

@end
