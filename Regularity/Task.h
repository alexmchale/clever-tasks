#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *due;
@property (nonatomic, retain) NSNumber *frequency;
@property (nonatomic, retain) NSDate *completed;
@property (nonatomic, retain) NSString *uuid;

- (void) toggleCompleted;
- (void) save;

+ (NSArray *) all;

@end
