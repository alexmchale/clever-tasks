#import "TaskListCell.h"

@implementation TaskListCell

@synthesize task;

- (void)setTask:(Task *)newTask
{
    task = newTask;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];    
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setDateStyle:NSDateFormatterShortStyle];
    
	self.textLabel.text = task.name;
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    
    NSString *time = [df stringFromDate:task.due];
    NSString *mode = [task describeFrequency];
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", time, mode];
    
    if (task.completed == nil)
        self.accessoryType = UITableViewCellAccessoryNone;
    else
        self.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
//    UIImage *backgroundImage = [UIImage imageNamed:@"px_by_Gre3g_light.png"];
    //        UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    //        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
    //        self.backgroundView.backgroundColor = backgroundColor;

    
//    CGContextRef c = UIGraphicsGetCurrentContext();
    
//    CGRect tiledRect;
//    tiledRect.origin = CGPointZero;
//    tiledRect.size = backgroundImage.size;
//    CGContextDrawTiledImage(c, tiledRect, backgroundImage.CGImage);
        
//    // Fill Gradient
//    CGGradientRef glossGradient;
//    CGColorSpaceRef rgbColorspace;
//    size_t num_locations = 2;
//    CGFloat locations[2] = { 0.0, 0.8 };
//    CGFloat components[8] = { 240./255., 243./255., 248./255., 0.95,   // Start color
//        225./255., 230./255., 233./255., 0.95 }; // End color
//    
//    rgbColorspace = CGColorSpaceCreateDeviceRGB();
//    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
//
//    CGRect currentBounds = self.bounds;
//    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
//    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMaxY(currentBounds));
//    CGContextDrawLinearGradient(c, glossGradient, topCenter, midCenter, 0);
//
//    CGGradientRelease(glossGradient);
//    CGColorSpaceRelease(rgbColorspace);
//    
//    CGFloat outer[4] = {0.0f, 0.0f, 0.0f, 0.10f};
//    CGContextSetStrokeColor(c, outer);
//    CGContextSetLineWidth(c, 3.0f);
//    CGContextBeginPath(c);
//    CGContextMoveToPoint(c, 0.0f, self.frame.size.height - 2.0f);
//    CGContextAddLineToPoint(c, self.frame.size.width - 0.0f, self.frame.size.height - 2.0f);
//    CGContextStrokePath(c);
//
//    CGFloat inner[4] = {0.0f, 0.0f, 0.0f, 1.0f};
//    CGContextSetStrokeColor(c, inner);
//    CGContextSetLineWidth(c, 0.5f);
//    CGContextBeginPath(c);
//    CGContextMoveToPoint(c, 0.0f, self.frame.size.height - 2.0f);
//    CGContextAddLineToPoint(c, self.frame.size.width - 0.0f, self.frame.size.height - 2.0f);
//    CGContextStrokePath(c);
}

@end
