//
//  DayView.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/26/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Period.h"
#import "Global.h"
#import "Tester.h"

@class Tester;


@interface DayView : UIView {
    int totalSize;
    UIViewController *dayViewController;
    Tester *tester;
    NSMutableArray *periods;
    NSDateFormatter *dateFormatter;
    NSDateFormatter *timeFormatter;
    NSDate* todayDate;
}

@property (nonatomic, strong) UIScrollView* dayScrollView;
@property (nonatomic, strong) NSString* dateString;
@property (nonatomic, assign) int totalSizeOfView;
//@property (nonatomic, strong) NSMutableArray *periods;

-(id)initWithDate:(NSDate*)date;

@end
