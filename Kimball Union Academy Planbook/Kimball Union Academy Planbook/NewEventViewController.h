//
//  NewEventViewController.h
//  Kimball Union Academy Planbook
//
//  Created by Nathaniel Lang on 3/22/15.
//  Copyright (c) 2015 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"


@interface NewEventViewController : UIViewController <UITextFieldDelegate> {
    NSDate *startDate;
    NSDate *endDate;
    NSDateFormatter *dateFormatter;
    NSString *dateFormat;
    
    NSString *eventName;
    NSString *eventDescription;
    NSString *eventDay;
    NSString *eventMonth;
    NSString *eventYear;
    NSString *eventStartTime;
    NSString *eventStartHour;
    NSString *eventStartMinute;
    NSString *eventEndTime;
    NSString *eventEndHour;
    NSString *eventEndMinute;
    
    BOOL startIsAM;
    BOOL endIsAM;
}

@property (strong, nonatomic) Event *event;
@property (weak, nonatomic) IBOutlet UITextField *eventNameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UITextField *dayField;
@property (weak, nonatomic) IBOutlet UITextField *monthField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *startHourField;
@property (weak, nonatomic) IBOutlet UITextField *startMinuteField;
@property (weak, nonatomic) IBOutlet UITextField *endHourField;
@property (weak, nonatomic) IBOutlet UITextField *endMinuteField;

-(IBAction)startAMPM:(id)sender;
-(IBAction)endAMPM:(id)sender;
-(IBAction)applyButton:(id)sender;
-(void)errorCheck;
-(void)createEvent;
@end
