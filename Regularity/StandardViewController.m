#import "StandardViewController.h"


@implementation StandardViewController

@synthesize myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"hixs_pattern_evolution.png"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    NSLog(@"img %@ color %@", backgroundImage, backgroundColor);

    [self.view setBackgroundColor:backgroundColor];
    [myTableView setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidUnload
{
    self.myTableView = nil;
    
    [super viewDidUnload];
}

@end
