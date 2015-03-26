//
//  DayView.h
//  Kimball Union Academy Planbook
//
//  Created by Nate Lang on 6/26/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Period.h"
#import "Global.h"
#import "Tester.h"
#import "Event.h"

@class Tester;


@interface DayView : UIView {
    int totalSize;
    UIViewController *dayViewController;
    Tester *tester;
    NSArray *periods;
    NSArray *events;
    NSDateFormatter *dateFormatter;
    NSDateFormatter *timeFormatter;
    NSDate* todayDate;
    NSDate *dayStart;
    NSDate *dayEnd;
    NSCalendar *cal;
}

@property (nonatomic, strong) UIScrollView* dayScrollView;
@property (nonatomic, strong) NSString* dateString;
@property (nonatomic, assign) int totalSizeOfView;
@property (nonatomic, strong) NSManagedObjectContext *context;

//@property (nonatomic, strong) NSMutableArray *periods;



-(id)initWithDate:(NSString*)date;

@end
