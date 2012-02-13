#import <UIKit/UIKit.h>

@interface FrequencySelectController : UIViewController
    <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *frequency;
@property (strong, nonatomic) EditReminderController *editReminderController;
@property FrequencyType selectedIndex;

@end
