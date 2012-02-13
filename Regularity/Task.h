#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define ONE_HOUR (60*60)
#define ONE_DAY (60*60*24)
#define ONE_WEEK (60*60*24*7)

typedef enum
{
    kFrequencyOnce,
    kFrequencyDaily,
    kFrequencyWeekly,
    kFrequencyMonthly,
    kFrequencyYearly
} FrequencyType;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *due;
@property (nonatomic, retain) NSNumber *frequency;
@property (nonatomic, retain) NSDate *completed;
@property (nonatomic, retain) NSString *uuid;

- (void) toggleCompleted;
- (void) save;
- (Task *) createNext;
- (FrequencyType) frequencyType;
- (BOOL) doesNextTaskExist;

+ (NSArray *) all;

@end
