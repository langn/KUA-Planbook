//
//  MonthViewController.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/24/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"
#import "Global.h"
#import "Tester.h"
#import "DayView.h"
#import "DayViewController.h"

@interface MonthViewController : UIViewController <CKCalendarDelegate, UIScrollViewDelegate> {
    UIScrollView* localDayScrollView;
    NSMutableArray *periods;
    NSCalendar *cal;
    Tester *tester;
    int totalSizeOfViewInt;
    NSDate *date;
}

@property (nonatomic, strong) UIScrollView* dayScrollView;
@property (nonatomic, strong) UIView* dayView;
@property (nonatomic, weak) Tester* tester;

@end
