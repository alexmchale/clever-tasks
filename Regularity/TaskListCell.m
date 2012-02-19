#import "TaskListCell.h"

@implementation TaskListCell

@synthesize task;

- (void)setTask:(Task *)newTask
{
    task = newTask;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];    
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setDateStyle:NSDateFormatterShortStyle];
    
    NSTimeInterval delta = [task.due timeIntervalSinceNow];
    NSInteger daysToGo = delta / ONE_DAY;
        
	self.textLabel.text = task.name;
    self.textLabel.adjustsFontSizeToFitWidth = YES;    
    self.detailTextLabel.text = [task describeTime];
    self.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    
    if (task.completed != nil) {
        // Task is completed, always color in light grey.
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
    } else if (daysToGo >= 0) {
        // Task is not yet due, color in a grey of strength with ratio to its delta.
        CGFloat greys[] = { 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7 };        
        CGFloat g = greys[URANGE(0, daysToGo, 7)];
        self.textLabel.textColor = [UIColor colorWithRed:g green:g blue:g alpha:1.0];
        self.detailTextLabel.textColor = [UIColor colorWithRed:g green:g blue:g alpha:1.0];
    } else {
        // Task is overdue
        CGFloat reds[] = { 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0 };
        CGFloat r = reds[URANGE(0, -daysToGo, 7)];
        NSLog(@"overdue task %@, red = %f", task.name, r);
        self.textLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.textColor = [UIColor colorWithRed:r green:0.3 blue:0.3 alpha:1.0];
    }
    
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
