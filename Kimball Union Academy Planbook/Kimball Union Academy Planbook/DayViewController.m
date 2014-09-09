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
    //[scrollView removeFromSuperview]; //probably not necessary
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
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    scrollView.delegate = self;
    [scrollView setScrollEnabled:YES];
    [scrollView setPagingEnabled:YES];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    if (date == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM.dd.yy"];
        date = [[NSDate alloc] init];
        date = [NSDate date];
        todayDateString = [dateFormatter stringFromDate:date];
        yesterdayDateString = [self getDateStringBackward:todayDateString];
        tomorrowDateString = [self getDateStringForward:todayDateString]; //need to make this method
    }
    
    yesterdayScrollView = [[UIScrollView alloc] init];
    currentDayScrollView = [[UIScrollView alloc] init];
    tomorrowScrollView = [[UIScrollView alloc] init];
    [yesterdayScrollView setDelegate:self];
    [currentDayScrollView setDelegate:self];
    [tomorrowScrollView setDelegate:self];
    [yesterdayScrollView setScrollEnabled:YES];
    [yesterdayScrollView setPagingEnabled:NO];
    [yesterdayScrollView setBackgroundColor:[UIColor lightGrayColor]];
    [currentDayScrollView setScrollEnabled:YES];
    [currentDayScrollView setPagingEnabled:NO];
    [currentDayScrollView setBackgroundColor:[UIColor lightGrayColor]];
    [tomorrowScrollView setScrollEnabled:YES];
    [tomorrowScrollView setPagingEnabled:NO];
    [tomorrowScrollView setBackgroundColor:[UIColor lightGrayColor]];
    
    yesterdayView = [[DayView alloc] initWithDate:yesterdayDateString];
    tomorrowView = [[DayView alloc] initWithDate:tomorrowDateString];
    currentDayView = [[DayView alloc] initWithDate:todayDateString];
    
    [self loadInitialDays];
    
    
    [scrollView addSubview:(currentDayView)];
    [self.view addSubview:(scrollView)];
    
    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0.0f) animated:NO];
    
    oldOffset = scrollView.contentOffset.x;
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    oldOffset = scrollView.contentOffset.x;
    oldOffsetY = scrollView.contentOffset.y;
    NSLog(@"Old offset %f",oldOffset);
    //[scrollView setPagingEnabled:NO];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float offset = scrollView.contentOffset.x;
    NSLog(@"Did end declerating");
    NSLog(@"Content offset is %f",offset);
    if (offset == 0 && oldOffset != 0) {
        tomorrowDateString = todayDateString;
        todayDateString = yesterdayDateString;
        totalSizeOfTomorrowViewInt = totalSizeOfTodayViewInt; //moves the size of the views around so that they will correspond to the correct view
        totalSizeOfTodayViewInt = totalSizeOfYesterdayViewInt;
        [tomorrowView removeFromSuperview];
        [viewsInMemory replaceObjectAtIndex:2 withObject:[viewsInMemory objectAtIndex:1]];
        tomorrowView = [viewsInMemory objectAtIndex:2];
        [viewsInMemory replaceObjectAtIndex:1 withObject:[viewsInMemory objectAtIndex:0]];
        currentDayView = [viewsInMemory objectAtIndex:1];
        [self findPreviousDay]; //in this function the totalSizeOfYesterdayViewInt is changes to represent the actual size of yesterday view
        yesterdayView = [viewsInMemory objectAtIndex:0];
        [scrollView addSubview:yesterdayView];
        [currentDayScrollView addSubview:currentDayView];
        [tomorrowScrollView addSubview:tomorrowView];
        [yesterdayScrollView addSubview:yesterdayView];
        //currentDayView.frame = CGRectMake(320, 0, 320, currentDayView.totalSizeOfView);
        //tomorrowView.frame = CGRectMake(640, 0, 320, tomorrowView.totalSizeOfView);
        //yesterdayView.frame = CGRectMake(0, 0, 320, yesterdayView.totalSizeOfView); //maybe unneccesary
        
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, -64.0f) animated:NO];
        [scrollView setContentSize:CGSizeMake(960, currentDayView.totalSizeOfView)];
        int contentSize = currentDayView.totalSizeOfView;
        
    }
    if (offset >= 640 && oldOffset != 640) {
        yesterdayDateString = todayDateString;
        todayDateString = tomorrowDateString;
        
        [yesterdayView removeFromSuperview];
        [viewsInMemory replaceObjectAtIndex:0 withObject:[viewsInMemory objectAtIndex:1]];
        yesterdayView = [viewsInMemory objectAtIndex:0];
        [viewsInMemory replaceObjectAtIndex:1 withObject:[viewsInMemory objectAtIndex:2]];
        currentDayView = [viewsInMemory objectAtIndex:1];
        [self findNextDay];
        tomorrowView = [viewsInMemory objectAtIndex:2];
        //periods = [Global getPeriodsForDay:todayDateString];
        //totalSizeOfTodayViewInt = [self calculateTotalSizeOfView];
        //currentDayView.frame = CGRectMake(320, 0, 320, currentDayView.totalSizeOfView);
        [currentDayScrollView addSubview:currentDayView];
        [tomorrowScrollView addSubview:tomorrowView];
        [yesterdayScrollView addSubview:yesterdayView];
        //tomorrowView.frame = CGRectMake(640, 0, 320, tomorrowView.totalSizeOfView);
        //yesterdayView.frame = CGRectMake(0, 0, 320, yesterdayView.totalSizeOfView);
        //[scrollView addSubview:tomorrowView];
        
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, -64.0f) animated:NO];
        [scrollView setContentSize:CGSizeMake(960, currentDayView.totalSizeOfView)];
        
    }
    //scrollView.userInteractionEnabled = YES;
}




-(void)loadInitialDays {
    //first two bits of code get the current day and load that days dayView, next bits take the proceeding/succeeding days and do the same
    
    
    periods = [Global getPeriodsForDay:todayDateString];
    totalSizeOfTodayViewInt = [self calculateTotalSizeOfView];
    self.dayView = [Global getDayView:todayDateString];
    [viewsInMemory replaceObjectAtIndex:1 withObject:self.dayView];
    currentDayView = [viewsInMemory objectAtIndex:1];
    
    [currentDayScrollView setFrame:CGRectMake(320, 0, 320, self.view.frame.size.height)];
    [currentDayView setFrame:CGRectMake(0, 0, 320, totalSizeOfTodayViewInt)];
    
    [currentDayScrollView addSubview:currentDayView];
    [scrollView addSubview:currentDayScrollView];
    
    
    [self findPreviousDay];
    [yesterdayScrollView addSubview:yesterdayView];
    [scrollView addSubview:yesterdayScrollView];
    
    [self findNextDay];
    [tomorrowScrollView addSubview:tomorrowView];
    [scrollView addSubview:tomorrowScrollView];
    
}
-(NSString*)getDateStringBackward:(NSString *)dateString {
    
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
        if (parsedDay < 10) {
            return [NSString stringWithFormat:@"0%d.0%d.%d",parsedMonth, parsedDay, parsedYear];
            
        }
        else {
            return [NSString stringWithFormat:@"0%d.%d.%d",parsedMonth, parsedDay, parsedYear];
        }
    }
    else {
        if (parsedDay < 10) {
            return [NSString stringWithFormat:@"%d.0%d.%d",parsedMonth, parsedDay, parsedYear];
        }
        return [NSString stringWithFormat:@"%d.%d.%d",parsedMonth, parsedDay, parsedYear];
    }
}

-(void)findPreviousDay{
    yesterdayDateString = [self getDateStringBackward:todayDateString];
    self.dayView = [Global getDayView:yesterdayDateString];
    periods = [Global getPeriodsForDay:yesterdayDateString];
    totalSizeOfYesterdayViewInt = [self calculateTotalSizeOfView];
    yesterdayView = self.dayView;
    [yesterdayScrollView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [yesterdayView setFrame:CGRectMake(0, 0, 320, totalSizeOfYesterdayViewInt)];
    [viewsInMemory replaceObjectAtIndex:0 withObject:yesterdayView];
}

-(NSString*)getDateStringForward:(NSString *)dateString {
    
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
        if (parsedDay < 10) {
            return [NSString stringWithFormat:@"0%d.0%d.%d",parsedMonth, parsedDay, parsedYear];
            
        }
        else {
            return [NSString stringWithFormat:@"0%d.%d.%d",parsedMonth, parsedDay, parsedYear];
        }
    }
    else {
        if (parsedDay < 10) {
            return [NSString stringWithFormat:@"%d.0%d.%d",parsedMonth, parsedDay, parsedYear];
        }
        return [NSString stringWithFormat:@"%d.%d.%d",parsedMonth, parsedDay, parsedYear];
    }
    
}

-(void)findNextDay {
    tomorrowDateString = [self getDateStringForward:todayDateString];
    self.dayView = [Global getDayView:tomorrowDateString];
    periods = [Global getPeriodsForDay:tomorrowDateString];
    totalSizeOfTomorrowViewInt = [self calculateTotalSizeOfView];
    tomorrowView = self.dayView;
    [tomorrowScrollView setFrame:CGRectMake(620, 0, 320, self.view.frame.size.height)];
    [tomorrowView setFrame:CGRectMake(0, 0, 320, totalSizeOfTomorrowViewInt)];
    [viewsInMemory replaceObjectAtIndex:2 withObject:self.dayView];
}

-(void)viewDidLayoutSubviews {
    [scrollView setContentSize:CGSizeMake(960, currentDayView.totalSizeOfView)];
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

@end
