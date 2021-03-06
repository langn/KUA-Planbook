   //
//  MonthViewController.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/24/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "MonthViewController.h"


@interface MonthViewController ()
#define PIXEL_MINUTE_RATIO 2.3f
@end

@implementation MonthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(int)calculateTotalSizeOfView {
    
    int totalSizePre = 0;
    for (Period *period in periods) { //loops thorugh all of the periods in the periods array
        NSDate *startDate = period.startTime; //takes the startTime property (NSDate) of the period objects
        NSDate *endDate = period.endTime; //takes the endTime property (NSDate) of the period objects
        cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //Use this cal to calculate time differences
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit; //Unit flags for hours and minutes
        NSDateComponents *comps = [cal components:unitFlags fromDate:startDate toDate:endDate options:0];
        int hourTimeDifference = (int)([comps hour] * 60); //take the difference of the hours and puts it in minutes
        int minuteTimeDifference = (int)([comps minute]); //difference in minutes
        int totalTimeDifference = hourTimeDifference + minuteTimeDifference; //ads the time differenes together
        totalSizePre += (int)(totalTimeDifference * PIXEL_MINUTE_RATIO);
        // int x = (int)totalSizePre;
    }
    return totalSizePre;
}


- (void)viewDidLoad
{
    float rectBottom = self.view.frame.size.height * .6;
    [super viewDidLoad];
    localDayScrollView = [Global dayScrollView];
    CKCalendarView *calendar = [[CKCalendarView alloc] init];
    [calendar setFrame:(CGRectMake(0, 64, self.view.frame.size.width, rectBottom))];
    [localDayScrollView setFrame:(CGRectMake(0, rectBottom, self.view.frame.size.width, self.view.frame.size.height - rectBottom))];
    tester = [Global tester];
    periods = tester.periods;
    cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    totalSizeOfViewInt = [self calculateTotalSizeOfView];
    float totalSizeOfViewFloat = (float)totalSizeOfViewInt;
    if (date == nil) {
        NSLocale* currentLocale = [NSLocale currentLocale];
        [date descriptionWithLocale:currentLocale];
    }
    self.dayView = [Global getDayView:date];
    [self.dayView setFrame:CGRectMake(0, 0, 320, totalSizeOfViewFloat)];
    [localDayScrollView setScrollEnabled:YES];
    localDayScrollView.backgroundColor = [UIColor lightGrayColor];
    [localDayScrollView setShowsVerticalScrollIndicator:YES];
    [localDayScrollView addSubview:(self.dayView)];
    [self.view addSubview:(localDayScrollView)];
    [self.view addSubview:calendar];
    [self.view addSubview:localDayScrollView];
    [calendar setDelegate:self];
    [localDayScrollView setDelegate:self];
}

-(void)viewDidLayoutSubviews{
    localDayScrollView.contentSize = CGSizeMake(320, totalSizeOfViewInt);
}
-(BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date{
    return YES;
}

-(void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)selectedDate {
    date = selectedDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
