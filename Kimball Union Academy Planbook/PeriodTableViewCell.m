//
//  PeriodTableViewCell.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/25/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//
/*

#import "PeriodTableViewCell.h"

@implementation PeriodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setUpForPeriod {
    totalSize = 0;
    static float const PIXEL_MINUTE_RATIO = 2.3; //Ratio of minutes of an event to pixels it takes adjusting changes width of events
    int const SCREEN_WIDTH = self.view.frame.size.width; //Constant for the width of the screen becuase I don't want to type it 132 times
    tester = [Global tester]; //points to the Global tester varibale so that it is the one that we are changing
    periods = tester.periods; //points? to the Global tester variables periods array so that we are accessing those periods
    int currentY = 0; //used to move the new views down in the scrollview so that they arent all on top of each other
    for (Period *period in periods) { //loops thorugh all of the periods in the periods array
        NSDate *startDate = period.startTime; //takes the startTime property (NSDate) of the period objects
        NSDate *endDate = period.endTime; //takes the endTime property (NSDate) of the period objects
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //Use this cal to calculate time differences
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit; //Unit flags for hours and minutes
        NSDateComponents *comps = [cal components:unitFlags fromDate:startDate toDate:endDate options:0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"h:mm a"];
        NSString *startDateString = [dateFormatter stringFromDate:startDate];
        int hourTimeDifference = [comps hour] * 60; //take the difference of the hours and puts it in minutes
        int minuteTimeDifference = [comps minute]; //difference in minutes
        int totalTimeDifference = hourTimeDifference + minuteTimeDifference; //ads the time differenes together
        UIView *periodView = [[UIView alloc] initWithFrame:(CGRectMake(0, currentY, SCREEN_WIDTH, totalTimeDifference * PIXEL_MINUTE_RATIO))]; //makes a view for the period
        periodView.backgroundColor = [UIColor yellowColor];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 50, 15))];//label for start time
        [timeLabel setText:startDateString];
        [periodView addSubview:timeLabel]; //ads the start time label to the period view
        [self.dayScrollView addSubview:periodView]; //adds the period view to the scrollview
        totalSize +=totalTimeDifference; //NEED TO ADD PASSING TIME SUPPORT
        currentY += totalTimeDifference * PIXEL_MINUTE_RATIO; //ups the current Y pos
    }
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end */
