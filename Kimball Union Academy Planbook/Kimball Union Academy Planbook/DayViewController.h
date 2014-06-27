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
}

@property (strong, nonatomic) UIView *dayView;
@property (assign) NSInteger *totalSize;
+(UIScrollView*)getDayScrollView;
@end
