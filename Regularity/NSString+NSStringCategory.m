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

@end
