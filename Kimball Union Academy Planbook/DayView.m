//
//  DayView.m
//  Kimball Union Academy Planbook
//
//  Created by Nate Lang on 6/26/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

//TODO
//Make different days less bold

#import "DayView.h"


@implementation DayView

//default init if there is no specific date (not used)
- (id)initWithFrame:(CGRect)frame {
    //periods = periodsInput;
    dayViewController = [Global dayViewController];
    self = [super initWithFrame:frame];
    if (self) {
        [self addPeriods];
    }
    return self;
}

//initialize the new DayView for a specific date (NSString argument)
-(id)initWithDate:(NSString*)date {
    dayViewController = [Global dayViewController]; //reference the global viewController
    
    cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //set the calendar to be gregorian
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM.dd.yy"]; //make a date formatter to parse the dateString
    self.dateString = date;
    
    dayStart = [dateFormatter dateFromString:self.dateString]; //creates the start and end days to be the same (NSDate)
    dayEnd = [dateFormatter dateFromString:self.dateString];
    
    NSDateComponents *dayStartComponents = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:dayStart]; //grab the curent y/m/d comps we don't want to change these
    NSDateComponents *dayEndComponents = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:dayStart];
    
    [dayStartComponents setHour: 0]; //set the hour minute and sec to the beginning of the day
    [dayStartComponents setMinute: 0];
    [dayStartComponents setSecond: 0];
    
    [dayEndComponents setHour: 23]; //set the hour minute and sec to the end of the day
    [dayEndComponents setMinute: 59];
    [dayEndComponents setSecond: 59];
    
    dayStart = [cal dateFromComponents:dayStartComponents]; //create startDate and endDate
    dayEnd = [cal dateFromComponents:dayEndComponents];
    
    
    self = [super init]; //run the add periods method and init the object
    if (self) {
        [self addPeriods];
        [self addEvents];
    }
    return self;
}


-(void)addPeriods {
    //totalSize = 64;
    static float const PIXEL_MINUTE_RATIO = 2.3; //Ratio of minutes of an event to pixels it takes adjusting changes width of events
    int const SCREEN_WIDTH = [UIScreen mainScreen].applicationFrame.size.width; //Constant for the width of the screen becuase I don't want to type it 132 times
    UIView *periodView;
    UILabel *startLabel;
    UILabel *endLabel;
    BOOL gap = NO;
    BOOL overlapping = NO;
 
    
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
            morningTime = [cal dateFromComponents:morningComps]; //sets the moning time to be 8:00 AM on the day that I am working with
            
            
            if (currentPeriod > 0){ //set oldPeriod only if the currentPeriod is not the first period of the day
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
            
            //super sloppy, I will smash all of this into a for loop
            
            BOOL hasOtherTitle = NO;
            
            
            if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"aPeriodTitle"] isEqual:(NSString *)[NSNull null]]) {
                if ([period.title isEqual:@"A"]) {
                    [periodLabel setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"aPeriodTitle"]];
                    hasOtherTitle = YES;
                }
            }
           
            if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"bPeriodTitle"] isEqual:(NSString *)[NSNull null]]) {
                if ([period.title isEqual:@"B"]) {
                    [periodLabel setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"bPeriodTitle"]];
                    hasOtherTitle = YES;
                }
            }
           
            
            if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"cPeriodTitle"] isEqual:(NSString *)[NSNull null]]) {
                if ([period.title isEqual:@"C"]) {
                    [periodLabel setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"cPeriodTitle"]];
                    hasOtherTitle = YES;
                }
            }
         
            
            if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"dPeriodTitle"] isEqual:(NSString *)[NSNull null]]) {
                if ([period.title isEqual:@"D"]) {
                    [periodLabel setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"dPeriodTitle"]];
                    hasOtherTitle = YES;
                }
            }
          
            
            if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"ePeriodTitle"] isEqual:(NSString *)[NSNull null]]) {
                if ([period.title isEqual:@"E"]) {
                    [periodLabel setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"ePeriodTitle"]];
                    hasOtherTitle = YES;
                }
            }
        
            if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"fPeriodTitle"] isEqual:(NSString *)[NSNull null]]) {
                if ([period.title isEqual:@"F"]) {
                    [periodLabel setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"fPeriodTitle"]];
                    hasOtherTitle = YES;
                }
            }
       
            
            if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"gPeriodTitle"] isEqual:(NSString *)[NSNull null]]) {
                if ([period.title isEqual:@"G"]) {
                    [periodLabel setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"gPeriodTitle"]];
                    hasOtherTitle = YES;
                }
            }
            if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"hPeriodTitle"] isEqual:(NSString *)[NSNull null]]) {
                if ([period.title isEqual:@"H"]) {
                    [periodLabel setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"hPeriodTitle"]];
                    hasOtherTitle = YES;
                }
            }
            if (!hasOtherTitle) {
                [periodLabel setText:period.title];
                
            }
            
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

-(void)addEvents {
    //totalSize = 64;
    static float const PIXEL_MINUTE_RATIO = 2.3; //Ratio of minutes of an event to pixels it takes adjusting changes width of events
    int const SCREEN_WIDTH = self.frame.size.width; //Constant for the width of the screen becuase I don't want to type it 132 times
    UIView *eventView;
    UILabel *startLabel;
    UILabel *endLabel;
    BOOL gap = NO;
    BOOL overlapping = NO;
    
    
    //code below is to fetch events in a day from core data
    NSPredicate *eventsForDateString = [NSPredicate predicateWithFormat:@"(startTime >= %@) AND (endTime <= %@)", dayStart, dayEnd];
    events = [Event MR_findAllSortedBy:@"startTime" ascending:YES withPredicate:eventsForDateString];
    
    
    Event *oldEvent;
    int currentY = 0; //used to move the new views down in the scrollview so that they arent all on top of each other
    
    int currentEvent = 0;
    
    
    //if the start time != the end time of the last event add the appropriate gap, first eventstart from 8
    timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"h:mm"];
    NSDate *morningTime = [[NSDate alloc] init];
    
    
    for (Event *event in events) { //loops thorugh all of the events in the events array
        if (event != nil) {
            
            //get start and end dates
            NSDate *startDate = event.startTime; //takes the startTime property (NSDate) of the event objects
            NSDate *endDate = event.endTime; //takes the endTime property (NSDate) of the event objects
            
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
            morningTime = [cal dateFromComponents:morningComps]; //sets the moning time to be 8:00 AM on the day that I am working with
            
            
            if (currentEvent > 0){ //set oldEvent only if the currentEvent is not the first event of the day
                oldEvent = [events objectAtIndex:currentEvent - 1];
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
            
            NSDate *oldEventEndTime = [[NSDate alloc] init];
            oldEventEndTime = oldEvent.startTime;
            
            //see if end time of before is the same as the start time of now, if not do certain things
            if ((oldEventEndTime != startDate)) {
                if (oldEventEndTime > startDate) { //overlapping
                    overlapping = YES;
                }
                
                else if (oldEventEndTime < startDate) { //there is a gap
                    gap = YES;
                }
            }
            
            //set the old times
            
            //TODO CHANGE THESE SO THAT LUNCH AND DINNER DISPLAY TIMES ON TOP TIME INSTEAD OF TOP AND BOTTOM
            
            if (!overlapping) {
                eventView = [[UIView alloc] initWithFrame:(CGRectMake(0, totalTimeDifferenceFromMorning * PIXEL_MINUTE_RATIO, SCREEN_WIDTH,totalTimeDifference * PIXEL_MINUTE_RATIO))]; //makes a view for the event
                currentY = ((totalTimeDifference * PIXEL_MINUTE_RATIO) + (totalTimeDifferenceFromMorning * PIXEL_MINUTE_RATIO)); //ups the current Y pos
                UILabel *startLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 75, 15))];//label for start time
                UILabel *endLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, (totalTimeDifference * PIXEL_MINUTE_RATIO) - 20, 75, 15))];
                [startLabel setText:startDateString];
                [endLabel setText:endDateString];
                [eventView addSubview:startLabel]; //ads the start time label to the event view
                [eventView addSubview:endLabel];
            }
            else {
                eventView = [[UIView alloc] initWithFrame:(CGRectMake(0, currentY, SCREEN_WIDTH,totalTimeDifference * PIXEL_MINUTE_RATIO))]; //makes a view for the event
                currentY = (currentY + (totalTimeDifference * PIXEL_MINUTE_RATIO));
                UILabel *startLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 120, 15))];//label for start time
                NSString* startLabelText = [NSString stringWithFormat:@"%@ - %@",startDateString,endDateString];
                [startLabel setText:startLabelText];
               
                [eventView addSubview:startLabel]; //ads the start time label to the event view
            }
            UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"periodBackground"]];
            backgroundImageView.contentMode = UIViewContentModeScaleToFill;
            [eventView addSubview:backgroundImageView];
            [eventView sendSubviewToBack:backgroundImageView];
            [backgroundImageView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, totalTimeDifference * PIXEL_MINUTE_RATIO)];
            
            UILabel *eventLabel = [[UILabel alloc] initWithFrame:(CGRectMake(80, 10, 210, 20))];
            [eventLabel setTextAlignment:NSTextAlignmentRight];
            [eventLabel setText:event.title];
            eventView.alpha = .75;
            
            
            [eventView addSubview:eventLabel];
            [self addSubview:eventView]; //adds the event view to the view
            
            totalSize = currentY;
            
            overlapping = NO;
            gap = NO;
            
            currentEvent++;
        }
        
    
    }

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
