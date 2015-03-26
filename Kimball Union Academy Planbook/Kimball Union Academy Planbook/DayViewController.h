//
//  DayViewController.h
//  Kimball Union Academy Planbook
//
//  Created by Nate Lang on 6/25/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
@class Tester;
@class DayView;

@interface DayViewController : UIViewController <UIScrollViewDelegate> {
    Tester *tester;
    NSMutableArray *periods;
    NSMutableArray *viewsInMemory;
    int totalSizeOfViewInt;
    UIScrollView *localDayScrollView;
    UIScrollView *localDayScrollViewLeft;
    UIScrollView *localDayScrollViewRight;
    NSDate *date;
    NSCalendar *cal;
    NSDateFormatter *dateFormatter;
    NSDateFormatter *titleDateFormatter;
    //NSString *dateString;
    CGPoint viewStartLocation;
    DayView *currentDayView;
    DayView *yesterdayView;
    DayView *tomorrowView;
    UIScrollView *scrollView;
    NSString *yesterdayDateString;
    NSString *tomorrowDateString;
    NSString *todayDateString;
    NSString *titleDateString;
    //to keep track of where the view started so that we know when to switch the view
    int totalSizeOfTodayViewInt;
    int totalSizeOfYesterdayViewInt;
    int totalSizeOfTomorrowViewInt;
    float oldOffset;
    CGPoint oldContentOffset;
}

@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (strong, nonatomic) DayView *dayView;
@property (assign) NSInteger *totalSize;
+(UIScrollView*)getDayScrollView;

-(NSString*)getDateStringBackward:(NSString *)dateString;

@end
