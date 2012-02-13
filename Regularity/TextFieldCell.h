#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell
{
    UILabel *label;
    UITextField *text;
}

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *text;

+ (id) cellForTableView:(UITableView *)tableView;
+ (id) cellForTableView:(UITableView *)tableView labeled:(NSString *)name;

- (void) adjustSizeFor:(UITableView *)tableView;
- (NSString *) value;
- (void) setValue:(NSString *)value;

@end
