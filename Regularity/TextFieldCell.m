#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize label, text;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    
    if (selected) [text becomeFirstResponder];
}

- (void) adjustSizeFor:(UITableView *)tableView
{
    CGRect tableFrame = tableView.frame;
    int yOffset = 10;
    int height = self.frame.size.height - (2 * yOffset);
    int wOffset = IS_IPAD ? 100 : 25;
    int textFieldOffset = label ? 95 : 10;

    if (label)
        label.frame = CGRectMake(10, yOffset, textFieldOffset, height);
    
    text.frame = CGRectMake(textFieldOffset, yOffset, tableFrame.size.width - wOffset - textFieldOffset, height);
    
    [tableView setNeedsLayout];
}

- (id) initWithTableView:(UITableView *)tableView named:(NSString *)name
{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (name) {
        label = [[UILabel alloc] init];
        label.text = name;
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
    }
    
    text = [[UITextField alloc] init];
    text.textColor = [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
    text.autocorrectionType = UITextAutocorrectionTypeNo;
    text.autocapitalizationType = UITextAutocapitalizationTypeNone;
    text.clearButtonMode = UITextFieldViewModeWhileEditing;
    text.returnKeyType = UIReturnKeyDone;
    text.adjustsFontSizeToFitWidth = YES;
    
    if (label) [self.contentView addSubview:label];
    [self.contentView addSubview:text];
    
    [self adjustSizeFor:tableView];
    
    return self;
}

- (NSString *) value
{
    return text.text;
}

- (void) setValue:(NSString *)value
{
    text.text = value ? value : @"";
}

+ (id) cellForTableView:(UITableView *)tableView
{
    return [self cellForTableView:tableView labeled:nil];
}

+ (id) cellForTableView:(UITableView *)tableView labeled:(NSString *)name
{
    id cell = [tableView dequeueReusableCellWithIdentifier:name];
    
    if (cell == nil) {
        cell = [[TextFieldCell alloc] initWithTableView:tableView named:name];
    }
    
    return cell;
}

@end
