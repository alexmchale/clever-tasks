#import "NSString+NSStringCategory.h"

@implementation NSString (NSStringCategory)

+ (NSString *) generateUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *) string;
}

@end
