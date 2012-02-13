//
//  ViewController.m
//  Regularity
//
//  Created by Alex McHale on 1/23/12.
//  Copyright (c) 2012 Gemini SBS. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize reminderTableView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setReminderTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    reminderTableView.editing = NO;
    [self reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) reloadData
{
    tasks = [Task all];
    [reminderTableView reloadData];
}

- (IBAction)editButtonSelected:(id)sender
{
    [reminderTableView setEditing:!reminderTableView.editing animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"task count = %d", [tasks count]);
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
    
    NSLog(@"cell = %@", cell);
    
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
	}
	
	// get the view controller's info dictionary based on the indexPath's row
	cell.textLabel.text = [item name];
    cell.detailTextLabel.text = [df stringFromDate:[item due]];
    
    NSLog(@"completed = %@", item.completed);
    
    if (item.completed == nil)
        cell.accessoryType = UITableViewCellAccessoryNone;
    else
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
	
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
            NSLog(@"index of next task = %d", indexOfNextTask);
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
    NSLog(@"editing style = %d", editingStyle);
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Task *task = [tasks objectAtIndex:indexPath.row];
        [CTX deleteObject:task];
        tasks = [Task all];
        NSArray *rows = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationLeft];
        // remove the row here.
    }
}

@end
