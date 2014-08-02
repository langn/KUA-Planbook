//
//  Global.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/24/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "Global.h"

static Tester* _tester = nil;
static UIScrollView* _dayScrollView = nil;
static UIViewController* _dayViewController = nil;
static NSMutableDictionary* dayViews = nil;
static NSMutableDictionary* periodsForDay = nil;
@implementation Global
+(void)loadTester { //public function to load and initialize the tester, makes sure that it does not already exist
    if (_tester == nil) {
    _tester  = [[Tester alloc] init];
    [_tester initGroups];
    [_tester initUsers];
    [_tester initDay1];
    [_tester initDay2];
    [_tester initDay3];
    [_tester initDay4];
    [_tester initDay5];
    }
    else  { //if it already exists prints a message to the log
        NSLog:(@"Tester already exists, another one was not created on the global scope");
        return;
    }
}
+(void)loadDayScrollView {
    if (_dayScrollView == nil) {
        _dayScrollView = [[UIScrollView alloc] init];
    }
    else {
        NSLog:(@"DayScrollView already exists, another one was not created on the global scope");
        return;
    }
}
+(void)loadDayViewController {
    if (_dayViewController == nil) {
        _dayViewController = [[DayViewController alloc] init];
    }
    else {
    NSLog:(@"DayScrollView already exists, another one was not created on the global scope");
        return;
    }

}

+(NSMutableArray*)getPeriodsForDay:(NSString*)date {
    NSMutableArray *periods = [periodsForDay objectForKey:date];
    if (periods == nil) {
        periods = [[NSMutableArray alloc] init];
        [periodsForDay setObject:periods forKey:date];
    }
    return periods;
}

+(void)setPeriodsForDay:(NSString*)date withPeriods:(NSMutableArray*)periods{
    if (periodsForDay == nil ) {
    periodsForDay = [[NSMutableDictionary alloc] init];
    }
    [periodsForDay setObject:periods forKey:date];

}

+(DayView*)getDayView:(NSString*)date {
    DayView *day = [dayViews objectForKey:date];
    if (day == nil) {
        day = [[DayView alloc] initWithDate:date];
        if (dayViews == nil) {
            dayViews = [[NSMutableDictionary alloc] init];
            [dayViews setObject:day forKey:date];
            
            }
        }
    return day;
}
+(void)setDayView:(NSString*)date withDayView:(DayView*)newDay{
    [dayViews setObject:newDay forKey:date];
}


+(Tester*)tester { //getter function for the tester, becuase it is static it will always be the same if it has been initialized
    return _tester;
}
+(UIScrollView*)dayScrollView {
    return _dayScrollView;
}
+(UIViewController*)dayViewController {
    return _dayViewController;
}
@end
