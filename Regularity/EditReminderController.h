//
//  EditReminderController.h
//  Regularity
//
//  Created by Alex McHale on 1/24/12.
//  Copyright (c) 2012 Gemini SBS. All rights reserved.
//



@interface EditReminderController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *mondayBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *dayOfWeek;
@property BOOL mondayIsOn;
@property (weak, nonatomic) IBOutlet UITextField *whatToDo;
@property (strong, nonatomic) IBOutlet UISegmentedControl *frequencyControl;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateControl;

- (IBAction)cancelButtonSelected:(id)sender;
- (IBAction)saveButtonSelected:(id)sender;
- (IBAction)whatEditingDone:(id)sender;

@end
