#import "StandardViewController.h"


@implementation StandardViewController

@synthesize myTableView;
@synthesize myToolbar;
@synthesize myNavigationBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"px_by_Gre3g.png"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [myToolbar setBackgroundImage:backgroundImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
//    UIView *backgroundView = [[UIView alloc] initWithFrame:myTableView.frame];
//    
//    NSLog(@"img %@ color %@", backgroundImage, backgroundColor);

    [self.view setBackgroundColor:backgroundColor];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    
//    [myTableView setBackgroundColor:backgroundColor];
//    [myTableView setBackgroundView:backgroundView];
}

- (void)viewDidUnload
{
    self.myTableView = nil;
    
    [super viewDidUnload];
}

- (void)fixCellAppearance:(UITableViewCell *)cell
{    
    UIImage *backgroundImage = [UIImage imageNamed:@"px_by_Gre3g_light.png"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    //backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75];
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.backgroundView.backgroundColor = backgroundColor;

}

@end
