//
//  EditReminderController.m
//  Regularity
//
//  Created by Alex McHale on 1/24/12.
//  Copyright (c) 2012 Gemini SBS. All rights reserved.
//

#import "EditReminderController.h"

@implementation EditReminderController
@synthesize whatToDo;
@synthesize frequency;
@synthesize due;
@synthesize dateControl;
@synthesize optionsTableView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    whatToDo = [TextFieldCell cellForTableView:optionsTableView labeled:@"Title"];
    whatToDo.text.placeholder = @"What do you need to do?";
    
    [optionsTableView reloadData];
    
    
    /*
    UIFont *font16 = [UIFont fontWithName:@"Yanone Kaffeesatz" size:16.0];
    UIFont *font20 = [UIFont fontWithName:@"Yanone Kaffeesatz" size:20.0];
    
    [whatToDo setFont:font20];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font16 forKey:UITextAttributeFont];
    [frequencyControl setTitleTextAttributes:attributes forState:UIControlStateNormal];

    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImage *backgroundImage = [UIImage imageNamed:@"hixs_pattern_evolution.png"];
    //NSLog(@"IMG %@", backgroundImage);
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
     
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *rows = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    [optionsTableView reloadRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewDidUnload
{
    [self setWhatToDo:nil];
    [self setDateControl:nil];
    [self setOptionsTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
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
    [optionsTableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Tell me about your task";
}

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

@end
