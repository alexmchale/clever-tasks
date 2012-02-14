#import <UIKit/UIKit.h>

@interface FrequencySelectController : StandardViewController
    <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) EditReminderController *editReminderController;
@property FrequencyType selectedIndex;

@end
