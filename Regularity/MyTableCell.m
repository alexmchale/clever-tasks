#import "MyTableCell.h"

@implementation MyTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
//        UIImage *backgroundImage = [UIImage imageNamed:@"px_by_Gre3g_light.png"];
//        UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
//        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
//        self.backgroundView.backgroundColor = backgroundColor;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
