//
//  DayView.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/26/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "DayView.h"


@implementation DayView

- (id)initWithFrame:(CGRect)frame {
    //periods = periodsInput;
    dayViewController = [Global dayViewController];
    self = [super initWithFrame:frame];
    if (self) {
        [self addPeriods];
    }
    return self;
}

-(id)initWithDate:(NSString*)date {
    dayViewController = [Global dayViewController];
    
    cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //set the calendar to be gregorian
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM.dd.yy"];
    //date = [NSDate date];
    //dateString = [dateFormatter stringFromDate:date];
    self.dateString = date;
    
    dayStart = [dateFormatter dateFromString:self.dateString]; //creates the start and end days to be the same (NSDate)
    dayEnd = [dateFormatter dateFromString:self.dateString];
    
    NSDateComponents *dayStartComponents = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:dayStart]; //grab the curent y/m/d comps we don't want to change these
    NSDateComponents *dayEndComponents = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:dayStart];
    
    [dayStartComponents setHour: 0]; //set the hour minute and sec to the beginning of the day (hopefully)
    [dayStartComponents setMinute: 0];
    [dayStartComponents setSecond: 0];
    
    [dayEndComponents setHour: 23]; //set the hour minute and sec to the end of the day (hopefully)
    [dayEndComponents setMinute: 59];
    [dayEndComponents setSecond: 59];
    
    dayStart = [cal dateFromComponents:dayStartComponents];
    dayEnd = [cal dateFromComponents:dayEndComponents];
    
    //NSLog(@"The start of the day is %@", dayStart);
    //NSLog(@"The end of the day is %@", dayEnd);
    
    self = [super init];
    if (self) {
        [self addPeriods];
    }
    return self;
}


-(void)addPeriods {
    totalSize = 64;
    static float const PIXEL_MINUTE_RATIO = 2.3; //Ratio of minutes of an event to pixels it takes adjusting changes width of events
    int const SCREEN_WIDTH = 320; //Constant for the width of the screen becuase I don't want to type it 132 times
    //tester = [Global tester]; //points to the Global tester varibale so that it is the one that we are changing
    //periods = tester.periods; //points? to the Global tester variables periods array so that we are accessing those periods //COMMENTED TO REPLACE TESTER DEFINITON OF PERIODS
    
    //code below is to fetch periods in a day from core data
    NSPredicate *periodsForDateString = [NSPredicate predicateWithFormat:@"(startTime >= %@) AND (endTime <= %@)", dayStart, dayEnd];
    periods = [Period MR_findAllSortedBy:@"startTime" ascending:YES withPredicate:periodsForDateString];
    
    //periods = [Global getPeriodsForDay:self.dateString];
    int currentY = 0; //used to move the new views down in the scrollview so that they arent all on top of each other
    timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"h:mm"];
    for (Period *period in periods) { //loops thorugh all of the periods in the periods array
        if (period != nil) {
            NSDate *startDate = period.startTime; //takes the startTime property (NSDate) of the period objects
            NSDate *endDate = period.endTime; //takes the endTime property (NSDate) of the period objects
            NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit; //Unit flags for hours and minutes
            NSDateComponents *comps = [cal components:unitFlags fromDate:startDate toDate:endDate options:0];

            NSString *startDateString = [timeFormatter stringFromDate:startDate];
            NSString *endDateString = [timeFormatter stringFromDate:endDate];
            int hourTimeDifference = (int)([comps hour] * 60); //take the difference of the hours and puts it in minutes
            int minuteTimeDifference = (int)([comps minute]); //difference in minutes
            int totalTimeDifference = hourTimeDifference + minuteTimeDifference; //ads the time differenes together
            UIView *periodView = [[UIView alloc] initWithFrame:(CGRectMake(0, currentY, SCREEN_WIDTH, totalTimeDifference * PIXEL_MINUTE_RATIO))]; //makes a view for the period
            UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"periodBackground"]];
            backgroundImageView.contentMode = UIViewContentModeScaleToFill;
            [periodView addSubview:backgroundImageView];
            [periodView sendSubviewToBack:backgroundImageView];
            [backgroundImageView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, totalTimeDifference * PIXEL_MINUTE_RATIO)];
            UILabel *startLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 75, 15))];//label for start time
            //UILabel *nameLabel = [[UILabel alloc] initWithFrame:(CGRectMake(150, 10, 50, 15))]; //label for period name, not there right now
            UILabel *endLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, (totalTimeDifference * PIXEL_MINUTE_RATIO) - 20, 75, 15))];
            UILabel *periodLabel = [[UILabel alloc] initWithFrame:(CGRectMake(290, 10, 20, 15))];
            [startLabel setText:startDateString];
            //[nameLabel setText:period.name] no name property of periods yet
            [endLabel setText:endDateString];
            [periodLabel setText:period.title];
            [periodView addSubview:startLabel]; //ads the start time label to the period view
            [periodView addSubview:endLabel];
            [periodView addSubview:periodLabel];
            [self addSubview:periodView]; //adds the period view to the view
            currentY += totalTimeDifference * PIXEL_MINUTE_RATIO; //ups the current Y pos
            totalSize = currentY;
            }
    }
    _totalSizeOfView = totalSize;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
