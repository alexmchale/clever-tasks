#import <UIKit/UIKit.h>

@interface StandardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIToolbar *myToolbar;
@property (weak, nonatomic) IBOutlet UINavigationBar *myNavigationBar;

- (void)fixCellAppearance:(UITableViewCell *)cell;

@end
