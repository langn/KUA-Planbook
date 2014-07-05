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
    if (date == nil) {
        date = [NSDate date];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM.dd.yy"];
        dateString = [dateFormatter stringFromDate:date];
        //NSLocale* currentLocale = [NSLocale currentLocale];
        //[date descriptionWithLocale:currentLocale];
    }
    tester = [Global tester];
    periods = [Global getPeriodsForDay:dateString];
    cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    totalSizeOfViewInt = [self calculateTotalSizeOfView];
    float totalSizeOfViewFloat = (float)totalSizeOfViewInt;
    
    self.dayView = [Global getDayView:dateString];
    [self.dayView setFrame:CGRectMake(0, 0, 320, totalSizeOfViewFloat)];
    localDayScrollView = [Global dayScrollView];
    [localDayScrollView setDelegate:self];
    [localDayScrollView setScrollEnabled:YES];
    localDayScrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, 320, self.view.frame.size.height))];
    localDayScrollView.backgroundColor = [UIColor lightGrayColor];
    [localDayScrollView setShowsVerticalScrollIndicator:YES];
    [localDayScrollView addSubview:(self.dayView)];
    [self.view addSubview:(localDayScrollView)];
    

    viewStartLocation = CGPointMake(self.dayView.center.x, self.dayView.center.y);
    
}



-(void)viewDidLayoutSubviews {
    localDayScrollView.contentSize = CGSizeMake(self.view.frame.size.width, (NSInteger)totalSizeOfViewInt);
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
    if (viewStartLocation.x - self.dayView.center.x > 300) {
        [localDayScrollView removeFromSuperview];
        [localDayScrollView setHidden:YES];
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
        [localDayScrollView addSubview:self.dayView];
        return;
    } //if the view goes off the screen to the left move back a day
    
    CGPoint translation = [recognizer translationInView:self.view];
    [self.dayView setCenter:CGPointMake(self.dayView.center.x + translation.x, self.dayView.center.y)];
    [localDayScrollView setScrollEnabled:NO];
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    [localDayScrollView setScrollEnabled:YES];
}
@end
