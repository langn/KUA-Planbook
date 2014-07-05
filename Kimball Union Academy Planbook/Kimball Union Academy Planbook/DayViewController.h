//
//  DayViewController.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/25/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "Tester.h"
#import "DayView.h"

@interface DayViewController : UIViewController <UIScrollViewDelegate> {
    Tester *tester;
    NSMutableArray *periods;
    int totalSizeOfViewInt;
    UIScrollView *localDayScrollView;
    NSDate *date;
    NSCalendar *cal;
    NSDateFormatter *dateFormatter;
    NSString *dateString;
    CGPoint viewStartLocation; //to keep track of where the view started so that we know when to switch the view
}

@property (strong, nonatomic) UIView *dayView;
@property (assign) NSInteger *totalSize;
+(UIScrollView*)getDayScrollView;
- (IBAction)didPan:(id)sender;

@end
