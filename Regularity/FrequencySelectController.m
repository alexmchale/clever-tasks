//
//  FrequencySelectController.m
//  Regularity
//
//  Created by Alex McHale on 2/13/12.
//  Copyright (c) 2012 Gemini SBS. All rights reserved.
//

#import "FrequencySelectController.h"


@implementation FrequencySelectController
@synthesize frequency;
@synthesize editReminderController;
@synthesize selectedIndex;

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [self setFrequency:nil];
    [self setFrequency:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = [Task describeFrequency:indexPath.row];
    cell.accessoryType = (indexPath.row == selectedIndex) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected = %d", indexPath.row);
    editReminderController.frequency = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissModalViewControllerAnimated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    editReminderController = sender;
    selectedIndex = editReminderController.frequency;
    NSLog(@"loading = %d", editReminderController.frequency);
}

- (IBAction)cancelButtonSelected:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
