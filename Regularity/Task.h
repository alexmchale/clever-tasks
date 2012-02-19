#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define ONE_MINUTE (60)
#define ONE_HOUR (60 * ONE_MINUTE)
#define ONE_DAY (24 * ONE_HOUR)
#define ONE_WEEK (7 * ONE_DAY)
#define THIRTY_DAYS (30 * ONE_DAY)
#define ONE_YEAR (365 * ONE_DAY)

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
- (NSCalendarUnit) localNotificationRepeatInterval;
- (NSString *) describeFrequency;
- (BOOL) doesNextTaskExist;
- (BOOL) scheduleable;
- (NSString *) describeTime;

+ (NSArray *) all;
+ (NSString *) describeFrequency:(FrequencyType)type;
+ (void) scheduleLocalNotifications;

@end
