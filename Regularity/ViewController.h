#import <UIKit/UIKit.h>

@interface ViewController : StandardViewController
    <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *tasks;
}

- (void) reloadData;
- (IBAction)editButtonSelected:(id)sender;

@end
