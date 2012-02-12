//
//  EditReminderController.m
//  Regularity
//
//  Created by Alex McHale on 1/24/12.
//  Copyright (c) 2012 Gemini SBS. All rights reserved.
//

#import "EditReminderController.h"

@implementation EditReminderController
@synthesize mondayBtn;
@synthesize mondayIsOn;
@synthesize whatToDo;
@synthesize frequencyControl;
@synthesize dateControl;
@synthesize dayOfWeek;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIFont *font16 = [UIFont fontWithName:@"Yanone Kaffeesatz" size:16.0];
    UIFont *font20 = [UIFont fontWithName:@"Yanone Kaffeesatz" size:20.0];
    
    [whatToDo setFont:font20];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font16 forKey:UITextAttributeFont];
    [frequencyControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImage *backgroundImage = [UIImage imageNamed:@"husk.png"];
    //NSLog(@"IMG %@", backgroundImage);
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [whatToDo becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setDayOfWeek:nil];
    [self setMondayBtn:nil];
    [self setWhatToDo:nil];
    [self setFrequencyControl:nil];
    [self setDateControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelButtonSelected:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveButtonSelected:(id)sender {
}

- (IBAction)whatEditingDone:(id)sender
{
    [sender resignFirstResponder];
}

@end
