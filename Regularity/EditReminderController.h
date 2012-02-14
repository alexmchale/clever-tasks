@interface EditReminderController : UIViewController
    <UITableViewDelegate, UITableViewDataSource>
{
}

@property (strong, nonatomic) TextFieldCell *whatToDo;
@property (nonatomic) FrequencyType frequency;
@property (strong, nonatomic) NSDate *due;

@property (weak, nonatomic) IBOutlet UITableView *optionsTableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateControl;

- (IBAction)cancelButtonSelected:(id)sender;
- (IBAction)saveButtonSelected:(id)sender;
- (IBAction)whatEditingDone:(id)sender;
- (IBAction)dateChanged:(id)sender;
- (void)donePressed:(id)sender;

@end
