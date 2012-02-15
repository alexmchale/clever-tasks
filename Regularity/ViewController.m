#import "ViewController.h"

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImage *navBackgroundImage = [UIImage imageNamed:@"ice_age.png"];
//    UIColor *navBackgroundColor = [UIColor colorWithPatternImage:navBackgroundImage];
//    
//    [self.myNavigationBar setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.myTableView.editing = NO;
    [self reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void) reloadData
{
    tasks = [Task all];
    [self.myTableView reloadData];
}

- (IBAction)editButtonSelected:(id)sender
{
    [self.myTableView setEditing:!self.myTableView.editing animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *kCellIdentifier = @"TaskList";
    Task *item = [tasks objectAtIndex:indexPath.row];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setDateStyle:NSDateFormatterShortStyle];
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
	}
	
	cell.textLabel.text = [item name];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    NSString *time = [df stringFromDate:[item due]];
    NSString *mode = [item describeFrequency];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", time, mode];
    
    if (item.completed == nil)
        cell.accessoryType = UITableViewCellAccessoryNone;
    else
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [self fixCellAppearance:cell];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Task *task = [tasks objectAtIndex:indexPath.row];
    [task toggleCompleted];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (task.completed == nil) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        Task *nextTask = [task createNext];
        
        if (nextTask != nil) {
            tasks = [Task all];
            NSInteger indexOfNextTask = [tasks indexOfObject:nextTask];
            NSArray *rows = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexOfNextTask inSection:0]];
            [tableView insertRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationRight];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *) indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Task *task = [tasks objectAtIndex:indexPath.row];
        [CTX deleteObject:task];
        tasks = [Task all];
        NSArray *rows = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationLeft];
        [CTX save:nil];
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"Your Tasks";
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
//    if (sectionTitle == nil) {
//        return nil;
//    }
//    
//    // Create label with section title
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(20, 6, 300, 30);
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor whiteColor];
//    label.shadowColor = [UIColor grayColor];
//    label.shadowOffset = CGSizeMake(0.0, 1.0);
//    label.font = [UIFont boldSystemFontOfSize:16];
//    label.text = sectionTitle;
//    
//    // Create header view and add label as a subview
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//    [view addSubview:label];
//    
//    return view;
//}

@end
