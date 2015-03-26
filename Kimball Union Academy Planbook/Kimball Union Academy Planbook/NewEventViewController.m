//
//  NewEventViewController.m
//  Kimball Union Academy Planbook
//
//  Created by Nathaniel Lang on 3/22/15.
//  Copyright (c) 2015 Nate Lang. All rights reserved.
//

#import "NewEventViewController.h"

@interface NewEventViewController ()

@end

@implementation NewEventViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.eventNameField setDelegate:self];
    [self.descriptionField setDelegate:self];
    [self.dayField setDelegate:self];
    [self.monthField setDelegate:self];
    [self.yearField setDelegate:self];
    [self.startHourField setDelegate:self];
    [self.endHourField setDelegate:self];
    [self.endMinuteField setDelegate:self];
    
    dateFormat = @"MMddyyyy'T'HH':'mm";
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    
    startIsAM = YES;
    endIsAM = YES;
    
    
    // Do any additional setup after loading the view.
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)startAMPM:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        startIsAM = YES;
    }
    else if (segmentedControl.selectedSegmentIndex == 1) {
        startIsAM = NO;
    }
    
}

-(IBAction)endAMPM:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    
    if (segmentedControl.selectedSegmentIndex == 1) {
        endIsAM = YES;
    }
    else if (segmentedControl.selectedSegmentIndex == 2) {
        endIsAM = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)applyButton:(id)sender { //POTENTIAL ISSUES: TIME IS OVER 12, NEEED TO NOT ALLOW THAT
    eventName = [self.eventNameField text];
    eventDescription = [self.descriptionField text];
    eventDay = [self.dayField text];
    eventMonth = [self.monthField text];
    eventYear = [self.yearField text];
    eventStartMinute = [self.startMinuteField text];
    eventStartHour = [self.startHourField text];
    eventEndMinute = [self.endMinuteField text];
    eventEndHour = [self.endHourField text];
    
    [self errorCheck];
    [self createEvent];
    
    
}


-(void)errorCheck { //NEED TO ADD CASES FOR ONE DIGIT DATES AND TIMES (ADD 0 BEFORE)

    if ([eventDay length] == 1) {
        NSString *tempString = eventDay;
        eventDay = [NSString stringWithFormat:@"0%@",tempString];
    }
    
    if ([eventMonth length] == 1) {
        NSString *tempString = eventMonth;
        eventMonth = [NSString stringWithFormat:@"0%@",tempString];
    }
    
    if ([eventStartMinute length] == 1) {
        NSString *tempString = eventStartMinute;
        eventStartMinute = [NSString stringWithFormat:@"0%@",tempString];
    }
    
    if ([eventStartHour length] == 1) {
        NSString *tempString = eventStartHour;
        eventStartHour = [NSString stringWithFormat:@"0%@",tempString];
    }
    
    if ([eventEndMinute length] == 1) {
        NSString *tempString = eventEndMinute;
        eventEndMinute = [NSString stringWithFormat:@"0%@",tempString];
    }
    
    if ([eventEndHour length] == 1) {
        NSString *tempString = eventEndHour;
        eventEndHour = [NSString stringWithFormat:@"0%@",tempString];
    }
    
    if (!startIsAM) {
        int startHour = [eventStartHour intValue];
        if (startHour < 12) {
        startHour = startHour + 12;
        eventStartHour = [NSString stringWithFormat:@"%d",startHour];
        }
    }
    
    if (!endIsAM) {
        int endHour = [eventEndHour intValue];
        if (endHour < 12) {
        endHour = endHour + 12;
        eventEndHour = [NSString stringWithFormat:@"%d",endHour];
        }
    }
    
    
}

-(void)createEvent {
    //set up time
    
    NSString *startTimeSum = [NSString stringWithFormat:@"%@%@%@T%@:%@",eventMonth,eventDay,eventYear,eventStartHour,eventStartMinute];
    NSString *endTimeSum = [NSString stringWithFormat:@"%@%@%@T%@:%@",eventMonth,eventDay,eventYear,eventEndHour,eventEndMinute];
    startDate = [[NSDate alloc] init];
    endDate = [[NSDate alloc] init];
    startDate = [dateFormatter dateFromString:startTimeSum];
    endDate = [dateFormatter dateFromString:endTimeSum];
    
    
    if (!self.event) {
        self.event = [Event MR_createEntity];
        
        self.event.title = eventName;
        self.event.details = eventDescription;
        self.event.startTime = startDate;
        self.event.endTime = endDate;
        
        [self saveContext];
        
        NSArray *test = [[NSArray alloc] init];
        test = [Event MR_findAll];
        
  
    }
        
}

- (void)saveContext {
   [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
