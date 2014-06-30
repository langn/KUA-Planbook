//
//  Global.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/24/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DayViewController.h"  
#import "DayView.h"

@class Tester;
@class DayView;

@interface Global : NSObject
+(void)loadTester; //declares public load function
+(void)loadDayScrollView;
+(void)loadDayViewController;
+(Tester*)tester; //declares public getter function
+(UIScrollView*)dayScrollView;
+(UIViewController*)dayViewController;
+(DayView*)getDayView:(NSString*)date;
+(NSMutableArray*)getPeriodsForDay:(NSString*)date;
+(void)setPeriodsForDay:(NSString*)date withPeriods:(NSMutableArray*)periods;
+(void)setDayView:(NSString*)date withDayView:(DayView*)newDay;

@end
