#import "EditReminderController.h"

@implementation EditReminderController

@synthesize whatToDo;
@synthesize frequency;
@synthesize due;
@synthesize dateControl;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    whatToDo = [TextFieldCell cellForTableView:self.myTableView labeled:@"Title"];
    
    whatToDo.text.placeholder = @"What do you need to do?";
    whatToDo.text.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    whatToDo.text.autocorrectionType = UITextAutocorrectionTypeYes;
    
    [whatToDo.text addTarget:self
                      action:@selector(donePressed:)
            forControlEvents:UIControlEventEditingDidEndOnExit];

    [self.myTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *rows = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    [self.myTableView reloadRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewDidUnload
{
    self.whatToDo = nil;
    self.dateControl = nil;

    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelButtonSelected:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveButtonSelected:(id)sender
{
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:CTX];
    Task *task = [[Task alloc] initWithEntity:desc insertIntoManagedObjectContext:CTX];
    
    task.name = [whatToDo value];
    task.due = [dateControl date];
    task.frequency = [NSNumber numberWithInteger:frequency];
    
    if (task.name != nil && ![task.name isEqualToString:@""])
    {
        [task save];
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)whatEditingDone:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)dateChanged:(id)sender
{
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]];
    [self.myTableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"Tell me about your task";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;

    switch (indexPath.row)
    {
        case 0:
            return whatToDo;
            
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];            
            cell.textLabel.text = @"Frequency";
            cell.detailTextLabel.text = [Task describeFrequency:frequency];     
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
            
        case 2:
        {
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            
            [df setTimeStyle:NSDateFormatterShortStyle];
            [df setDateStyle:NSDateFormatterShortStyle];

            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];            
            cell.textLabel.text = @"Due";
            cell.detailTextLabel.text = [df stringFromDate:[dateControl date]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0)
        [whatToDo.text resignFirstResponder];
    
    switch (indexPath.row)
    {
        case 0:
            break;
            
        case 1:
            [self performSegueWithIdentifier:@"RevealFrequencies" sender:self];
            break;
            
        case 2:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FrequencySelectController *frequencySelector = [segue destinationViewController];
    frequencySelector.editReminderController = self;
    frequencySelector.selectedIndex = frequency;
}

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

- (void) donePressed:(id)sender
{
    [whatToDo.text resignFirstResponder];
}

@end
