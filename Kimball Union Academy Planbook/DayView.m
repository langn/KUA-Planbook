//
//  DayView.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/26/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

//TODO
//Make stuff look better and format the day on the top of the bar to make more sense

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
    UIView *periodView;
    UILabel *startLabel;
    UILabel *endLabel;
    BOOL gap = NO;
    BOOL overlapping = NO;
    //tester = [Global tester]; //points to the Global tester varibale so that it is the one that we are changing
    //periods = tester.periods; //points? to the Global tester variables periods array so that we are accessing those periods //COMMENTED TO REPLACE TESTER DEFINITON OF PERIODS
    
    //code below is to fetch periods in a day from core data
    NSPredicate *periodsForDateString = [NSPredicate predicateWithFormat:@"(startTime >= %@) AND (endTime <= %@)", dayStart, dayEnd];
    periods = [Period MR_findAllSortedBy:@"startTime" ascending:YES withPredicate:periodsForDateString];
    
    Period *oldPeriod;
    int currentY = 0; //used to move the new views down in the scrollview so that they arent all on top of each other
    int currentPeriod = 0;
    

    //if the start time != the end time of the last period add the appropriate gap, first period start from 8
    timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"h:mm"];
    NSDate *morningTime = [[NSDate alloc] init];
    
    
    for (Period *period in periods) { //loops thorugh all of the periods in the periods array
        if (period != nil) {
            
            //get start and end dates
            NSDate *startDate = period.startTime; //takes the startTime property (NSDate) of the period objects
            NSDate *endDate = period.endTime; //takes the endTime property (NSDate) of the period objects
            
            NSString *startDateString = [timeFormatter stringFromDate:startDate];
            NSString *endDateString = [timeFormatter stringFromDate:endDate];
            
            NSUInteger componentsUnitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit; //Unit flags for y, m, d
            NSDateComponents *currentDateComps = [cal components:componentsUnitFlags fromDate:startDate];
            NSDateComponents *morningComps = [[NSDateComponents alloc] init];
            [morningComps setYear:[currentDateComps year]];
            [morningComps setMonth:[currentDateComps month]];
            [morningComps setDay:[currentDateComps day]];
            [morningComps setHour:8];
            [morningComps setMinute:00];
            morningTime = [cal dateFromComponents:morningComps];
            
            
            
            
            if (currentPeriod > 0){
                oldPeriod = [periods objectAtIndex:currentPeriod - 1];
            }
            
            
            //find time difference
            NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit; //Unit flags for hours and minutes
            NSDateComponents *comps = [cal components:unitFlags fromDate:morningTime toDate:startDate options:0];
            int hourTimeDifferenceFromMorning = (int)([comps hour] * 60); //take the difference of the hours and puts it in minutes
            int minuteTimeDifferenceFromMorning = (int)([comps minute]); //difference in minutes
            int totalTimeDifferenceFromMorning = hourTimeDifferenceFromMorning + minuteTimeDifferenceFromMorning; //adds the time differenes together
            comps = [cal components:unitFlags fromDate:startDate toDate:endDate options:0];
            int hourTimeDifference= (int)([comps hour] * 60); //take the difference of the hours and puts it in minutes
            int minuteTimeDifference = (int)([comps minute]); //difference in minutes
            int totalTimeDifference = hourTimeDifference + minuteTimeDifference; //adds the time differenes together
            
            NSDate *oldPeriodEndTime = [[NSDate alloc] init];
            oldPeriodEndTime = oldPeriod.startTime;
            
            //see if end time of before is the same as the start time of now, if not do certain things
            if ((oldPeriodEndTime != startDate) && ([period.title isEqualToString: @"Lunch" ] || [period.title isEqualToString:@"Dinner"])) {
                if (oldPeriodEndTime > startDate) { //overlapping
                    overlapping = YES;
            }
                
                else if (oldPeriodEndTime < startDate) { //there is a gap
                    gap = YES;
                }
            }
            
            //set the old times
            
            //TODO CHANGE THESE SO THAT LUNCH AND DINNER DISPLAY TIMES ON TOP TIME INSTEAD OF TOP AND BOTTOM
            
            if (!overlapping) {
                periodView = [[UIView alloc] initWithFrame:(CGRectMake(0, totalTimeDifferenceFromMorning * PIXEL_MINUTE_RATIO, SCREEN_WIDTH,totalTimeDifference * PIXEL_MINUTE_RATIO))]; //makes a view for the period
                currentY = ((totalTimeDifference * PIXEL_MINUTE_RATIO) + (totalTimeDifferenceFromMorning * PIXEL_MINUTE_RATIO)); //ups the current Y pos
                UILabel *startLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 75, 15))];//label for start time
                //UILabel *nameLabel = [[UILabel alloc] initWithFrame:(CGRectMake(150, 10, 50, 15))]; //label for period name, not there right now
                UILabel *endLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, (totalTimeDifference * PIXEL_MINUTE_RATIO) - 20, 75, 15))];
                [startLabel setText:startDateString];
                //[nameLabel setText:period.name] no name property of periods yet
                [endLabel setText:endDateString];
                [periodView addSubview:startLabel]; //ads the start time label to the period view
                [periodView addSubview:endLabel];
            }
            else {
                periodView = [[UIView alloc] initWithFrame:(CGRectMake(0, currentY, SCREEN_WIDTH,totalTimeDifference * PIXEL_MINUTE_RATIO))]; //makes a view for the period
               currentY = (currentY + (totalTimeDifference * PIXEL_MINUTE_RATIO));
                UILabel *startLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 120, 15))];//label for start time
                //UILabel *nameLabel = [[UILabel alloc] initWithFrame:(CGRectMake(150, 10, 50, 15))]; //label for period name, not there right now
                NSString* startLabelText = [NSString stringWithFormat:@"%@ - %@",startDateString,endDateString];
                [startLabel setText:startLabelText];
                //[nameLabel setText:period.name] no name property of periods yet
                [periodView addSubview:startLabel]; //ads the start time label to the period view
            }
            UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"periodBackground"]];
            backgroundImageView.contentMode = UIViewContentModeScaleToFill;
            [periodView addSubview:backgroundImageView];
            [periodView sendSubviewToBack:backgroundImageView];
            [backgroundImageView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, totalTimeDifference * PIXEL_MINUTE_RATIO)];
            
            UILabel *periodLabel = [[UILabel alloc] initWithFrame:(CGRectMake(80, 10, 210, 20))];
            [periodLabel setTextAlignment:NSTextAlignmentRight];
            
            [periodLabel setText:period.title];
            
            [periodView addSubview:periodLabel];
            [self addSubview:periodView]; //adds the period view to the view
            
            totalSize = currentY;
          
            overlapping = NO;
            gap = NO;
            
            currentPeriod++;
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
