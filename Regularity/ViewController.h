//
//  ViewController.h
//  Regularity
//
//  Created by Alex McHale on 1/23/12.
//  Copyright (c) 2012 Gemini SBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
    <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *tasks;
}

@property (strong, nonatomic) IBOutlet UITableView *reminderTableView;

- (void) reloadData;

@end
