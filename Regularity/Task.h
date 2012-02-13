#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *due;
@property (nonatomic, retain) NSNumber *frequency;

+ (NSArray *) all;

@end
