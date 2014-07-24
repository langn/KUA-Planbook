//
//  DayViewController.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/25/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "DayViewController.h"



@interface DayViewController ()

@end
#define PIXEL_MINUTE_RATIO 2.3f

@implementation DayViewController

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

-(void)viewDidDisappear:(BOOL)animated {
    //[localDayScrollView removeFromSuperview]; //probably not necessary
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    tester = [Global tester];
    cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    viewsInMemory = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 3; i++) {
        [viewsInMemory insertObject:[NSNull null] atIndex:i];
    }
    
    localDayScrollView = [Global dayScrollView];
    [localDayScrollView setDelegate:self];
    [localDayScrollView setScrollEnabled:YES];
    [localDayScrollView setPagingEnabled:YES];
    localDayScrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, 320, self.view.frame.size.height))];
    localDayScrollView.backgroundColor = [UIColor lightGrayColor];
    //currentDayView = [[UIView alloc] init];
    
    [self loadInitialDays];
    

    //currentDayView = [viewsInMemory objectAtIndex:0];
    //move down later[localDayScrollView setContentSize:CGSizeMake(960, currentDayView.frame.size.height)];
    [localDayScrollView addSubview:(currentDayView)];
    [self.view addSubview:(localDayScrollView)];
    

    
    
}

-(void)loadInitialDays {
    //first two bits of code get the current day and load that days dayView, next bits take the proceeding/succeeding days and do the same
    if (date == nil) {
        date = [NSDate date];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM.dd.yy"];
        dateString = [dateFormatter stringFromDate:date];
    }
    periods = [Global getPeriodsForDay:dateString];
    totalSizeOfViewInt = [self calculateTotalSizeOfView];
    self.dayView = [Global getDayView:dateString];
    [viewsInMemory replaceObjectAtIndex:1 withObject:self.dayView];
    
    currentDayView = [[UIView alloc] init];
    currentDayView = [viewsInMemory objectAtIndex:1];
    [currentDayView setFrame:CGRectMake(320, 0, 320, totalSizeOfViewInt)];
    [localDayScrollView addSubview:currentDayView];
    
    
    [self findPreviousDay];
    periods = [Global getPeriodsForDay:dateString];
    totalSizeOfViewInt = [self calculateTotalSizeOfView];
    currentDayView = [viewsInMemory objectAtIndex:0];
    [currentDayView setFrame:CGRectMake(0, 0, 320, totalSizeOfViewInt)];
    [localDayScrollView addSubview:currentDayView];

    [self findNextDay];
    periods = [Global getPeriodsForDay:dateString];
    totalSizeOfViewInt = [self calculateTotalSizeOfView];
    currentDayView = [viewsInMemory objectAtIndex:2];
    [currentDayView setFrame:CGRectMake(640, 0, 320, totalSizeOfViewInt)];
    [localDayScrollView addSubview:currentDayView];

}

-(void)findPreviousDay{
    NSRange dayRange = NSMakeRange(3, 2);
    NSRange monthRange = NSMakeRange(0, 2);
    NSRange yearRange = NSMakeRange(6, 2);
    NSString *dateToParse = [dateString substringWithRange:dayRange];
    NSString *monthString = [dateString substringWithRange:monthRange];
    NSString *yearString = [dateString substringWithRange:yearRange];
    int parsedDay = [dateToParse intValue];
    int parsedMonth = [monthString intValue];
    int parsedYear = [yearString intValue];
    parsedDay--;
    if (parsedDay == 0) { //could reorgainze this logic for slight optimization
        parsedMonth--;
        if (parsedMonth == 1 || parsedMonth == 3 || parsedMonth == 5 || parsedMonth == 7 || parsedMonth == 8 || parsedMonth == 10 || parsedMonth == 12) {
            parsedDay = 31;
        }
        else if (parsedMonth == 2 && (parsedYear % 4 == 0)){
            parsedDay = 29;
        }
        else if (parsedMonth == 2) {
            parsedDay = 28;
        }
        else {
            parsedDay = 30;
        }
        if (parsedMonth == 0) {
            parsedYear--;
            parsedMonth = 12;
        }
    }
    if (parsedMonth < 10) {
        dateString = [NSString stringWithFormat:@"0%d.%d.%d",parsedMonth, parsedDay, parsedYear];
    }
    else {
    dateString = [NSString stringWithFormat:@"%d.%d.%d",parsedMonth, parsedDay, parsedYear];
    }
    self.dayView = [Global getDayView:dateString];
    [viewsInMemory replaceObjectAtIndex:0 withObject:self.dayView];
}

-(void)findNextDay {
    NSDate *today = [[NSDate alloc] init];
    today = [NSDate date];
    dateString = [dateFormatter stringFromDate:today];
    NSRange dayRange = NSMakeRange(3, 2);
    NSRange monthRange = NSMakeRange(0, 2);
    NSRange yearRange = NSMakeRange(6, 2);
    NSString *dateToParse = [dateString substringWithRange:dayRange];
    NSString *monthString = [dateString substringWithRange:monthRange];
    NSString *yearString = [dateString substringWithRange:yearRange];
    int parsedDay = [dateToParse intValue];
    int parsedMonth = [monthString intValue];
    int parsedYear = [yearString intValue];
    parsedDay++;
    if (parsedMonth == 1 || parsedMonth == 3 || parsedMonth == 5 || parsedMonth == 7 || parsedMonth == 8 || parsedMonth == 10 || parsedMonth == 12) {
        if (parsedDay > 31) {
            parsedDay = 1;
            parsedMonth++;
        }
    }
    else if (parsedMonth == 2 && (parsedYear % 4 == 0)){
        if (parsedDay > 29) {
            parsedDay = 1;
            parsedMonth++;
        }
    }
    else if (parsedMonth == 2) {
        if (parsedDay > 28) {
            parsedDay = 1;
            parsedMonth++;
        }
    }
    else if (parsedDay >30){
        parsedDay = 1;
        parsedMonth++;
    }
    if (parsedMonth == 13) {
        parsedMonth = 1;
        parsedDay = 1;
        parsedYear++;
    }
    if (parsedMonth < 10) {
        dateString = [NSString stringWithFormat:@"0%d.%d.%d",parsedMonth, parsedDay, parsedYear];
    }
    else {
        dateString = [NSString stringWithFormat:@"%d.%d.%d",parsedMonth, parsedDay, parsedYear];
    }    self.dayView = [Global getDayView:dateString];
    [viewsInMemory replaceObjectAtIndex:2 withObject:self.dayView];
}

-(void)viewDidLayoutSubviews {
    [localDayScrollView setContentSize:CGSizeMake(960, currentDayView.frame.size.height)];
}
-(void)viewWillAppear:(BOOL)animated{

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

 - (IBAction)didPan:(UIPanGestureRecognizer *)recognizer {
    if (viewStartLocation.x - self.dayView.center.x > 0) {
        //[localDayScrollView removeFromSuperview];
        //[localDayScrollView setHidden:YES];
        NSRange dayRange = NSMakeRange(3, 2);
        NSRange monthRange = NSMakeRange(0, 2);
        NSRange yearRange = NSMakeRange(6, 2);
        NSString *dateToParse = [dateString substringWithRange:dayRange];
        NSString *monthString = [dateString substringWithRange:monthRange];
        NSString *yearString = [dateString substringWithRange:yearRange];
        int parsedDay = [dateToParse intValue];
        int parsedMonth = [monthString intValue];
        int parsedYear = [yearString intValue];
        parsedDay--;
        if (parsedDay == 0) { //could reorgainze this logic for slight optimization
            parsedMonth--;
            if (parsedMonth == 1 || parsedMonth == 3 || parsedMonth == 5 || parsedMonth == 7 || parsedMonth == 8 || parsedMonth == 10 || parsedMonth == 12) {
                parsedDay = 31;
            }
            else if (parsedMonth == 2 && (parsedYear % 4 == 0)){
                parsedDay = 29;
            }
            else if (parsedMonth == 2) {
                parsedDay = 28;
            }
            else {
                parsedDay = 30;
            }
            if (parsedMonth == 0) {
                parsedYear--;
            }
        }
        dateString = [NSString stringWithFormat:@"%d.%d.%d",parsedMonth, parsedDay, parsedYear];
        self.dayView = [Global getDayView:dateString];
        periods = [Global getPeriodsForDay:dateString];
        totalSizeOfViewInt = [self calculateTotalSizeOfView];
        [self.dayView setFrame:CGRectMake(0, 0, 320, totalSizeOfViewInt)];
        localDayScrollViewLeft = [Global dayScrollView];
        [localDayScrollViewLeft setDelegate:self];
        [localDayScrollViewLeft setScrollEnabled:YES];
        localDayScrollViewLeft = [[UIScrollView alloc] initWithFrame:(CGRectMake(300, 0, 320, self.view.frame.size.height))];
        localDayScrollViewLeft.backgroundColor = [UIColor lightGrayColor];
        [localDayScrollViewLeft setShowsVerticalScrollIndicator:YES];
        [localDayScrollViewLeft addSubview:(self.dayView)];
        [self.view addSubview:(localDayScrollViewLeft)];
        
        return;
    }  //if the view goes off the screen to the left move back a day
    
    CGPoint translation = [recognizer translationInView:self.view];
    [self.dayView setCenter:CGPointMake(self.dayView.center.x + translation.x, self.dayView.center.y)];
    [localDayScrollView setScrollEnabled:NO];
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    [localDayScrollView setScrollEnabled:YES];
}
@end
