//
//  Tester.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/23/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "Tester.h"


@implementation Tester

-(void)initGroups {
    //inits the groups array
    self.groups = [[NSMutableArray alloc] init];
    //init group 1 for testing purposes
    NSMutableArray *group1users = [[NSMutableArray alloc] initWithObjects:@"Nate Lang",@"Levy Byrd",@"Amber Yu",@"Storm Sidleu",@"Charlotte Pitts",@"Aaron Glaeser",@"Louise Zhang", nil];
    group1 = [[Group alloc] initWithParameters:@"AP French" withUsers:group1users withRegularPeriodBool:YES withRegularPeriod:@"C"];
    //adds the groups to the group to the groups array
    [self.groups addObject:group1];
    periodInt = 1;
}
-(void)initUsers {  
    //init example users for testing purposes
    user1 = [[User alloc] initWithParameters:@"Nate Lang" withGroups:[[NSMutableArray alloc] initWithObjects:group1, nil] withClassYear:2015];
}

-(void)initDay1{
    self.periods = [[NSMutableArray alloc] init];
    int startHour = 8;
    int endHour = 9;
    for (int i = 0; i < 5; i++) {
                switch (periodInt) {
            case 1: {
                periodString = @"A";
                break;
            }
            case 2: {
                periodString = @"B";
                break;
            }
            case 3: {
                periodString = @"C";
                break;
            }
            case 4: {
                periodString = @"D";
                break;
            }
            case 5: {
                periodString = @"E";
                break;
            }
            case 6: {
                periodString = @"F";
                break;
            }
            case 7: {
                periodString = @"G";
                periodInt = 1;
                break;
            }
                
            default:
                break;
        }
        NSDateComponents *startComps = [[NSDateComponents alloc] init];
        [startComps setYear:2014];
        [startComps setMonth:6];
        [startComps setDay:25];
        [startComps setHour:startHour];
        [startComps setMinute:30];
        [startComps setSecond:0];
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        startTime = [cal dateFromComponents:startComps];
        NSDateComponents *endComps = [[NSDateComponents alloc] init];
        [endComps setYear:2014];
        [endComps setMonth:6];
        [endComps setDay:25];
        [endComps setHour:endHour];
        [endComps setMinute:30];
        [endComps setSecond:0];
        NSDate *endTime = [cal dateFromComponents:endComps];
        Period *period = [[Period alloc] initWithDetails:periodString withStartTime:startTime withEndTime:endTime withHasPassingTime:NO];
        [self.periods addObject:period];
        periodInt++;
        startHour++;
        endHour++;
    }
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM.dd.yy"];
    dateString = [dateFormatter stringFromDate:startTime];
    [Global setPeriodsForDay:dateString withPeriods:self.periods];
}

-(void)initDay2{
    self.periods = [[NSMutableArray alloc] init];
    int startHour = 8;
    int endHour = 9;
    for (int i = 0; i < 5; i++) {
        switch (periodInt) {
            case 1: {
                periodString = @"A";
                break;
            }
            case 2: {
                periodString = @"B";
                break;
            }
            case 3: {
                periodString = @"C";
                break;
            }
            case 4: {
                periodString = @"D";
                break;
            }
            case 5: {
                periodString = @"E";
                break;
            }
            case 6: {
                periodString = @"F";
                break;
            }
            case 7: {
                periodString = @"G";
                periodInt = 1;
                break;
            }
                
            default:
                break;
        }
        NSDateComponents *startComps = [[NSDateComponents alloc] init];
        [startComps setYear:2014];
        [startComps setMonth:6];
        [startComps setDay:29];
        [startComps setHour:startHour];
        [startComps setMinute:0];
        [startComps setSecond:0];
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        startTime = [cal dateFromComponents:startComps];
        NSDateComponents *endComps = [[NSDateComponents alloc] init];
        [endComps setYear:2014];
        [endComps setMonth:6];
        [endComps setDay:29];
        [endComps setHour:endHour];
        [endComps setMinute:0];
        [endComps setSecond:0];
        NSDate *endTime = [cal dateFromComponents:endComps];
        Period *period = [[Period alloc] initWithDetails:periodString withStartTime:startTime withEndTime:endTime withHasPassingTime:NO];
        [self.periods addObject:period];
        periodInt++;
        startHour++;
        endHour++;
    }
    dateString = [dateFormatter stringFromDate:startTime];
    [Global setPeriodsForDay:dateString withPeriods:self.periods]; //sets the periods in the NSDictonary to the periods we just created
}

-(void)initDay3{
    self.periods = [[NSMutableArray alloc] init];
    int startHour = 8;
    int endHour = 9;
    for (int i = 0; i < 5; i++) {
        switch (periodInt) {
            case 1: {
                periodString = @"A";
                break;
            }
            case 2: {
                periodString = @"B";
                break;
            }
            case 3: {
                periodString = @"C";
                break;
            }
            case 4: {
                periodString = @"D";
                break;
            }
            case 5: {
                periodString = @"E";
                break;
            }
            case 6: {
                periodString = @"F";
                break;
            }
            case 7: {
                periodString = @"G";
                periodInt = 1;
                break;
            }
                
            default:
                break;
        }
        NSDateComponents *startComps = [[NSDateComponents alloc] init];
        [startComps setYear:2014];
        [startComps setMonth:6];
        [startComps setDay:27];
        [startComps setHour:startHour];
        [startComps setMinute:30];
        [startComps setSecond:0];
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        startTime = [cal dateFromComponents:startComps];
        NSDateComponents *endComps = [[NSDateComponents alloc] init];
        [endComps setYear:2014];
        [endComps setMonth:6];
        [endComps setDay:27];
        [endComps setHour:endHour];
        [endComps setMinute:30];
        [endComps setSecond:0];
        NSDate *endTime = [cal dateFromComponents:endComps];
        Period *period = [[Period alloc] initWithDetails:periodString withStartTime:startTime withEndTime:endTime withHasPassingTime:NO];
        [self.periods addObject:period];
        periodInt++;
        startHour++;
        endHour++;
    }
    dateString = [dateFormatter stringFromDate:startTime];
    [Global setPeriodsForDay:dateString withPeriods:self.periods]; //sets the periods in the NSDictonary to the periods we just created
}

-(void)initDay4{
    self.periods = [[NSMutableArray alloc] init];
    int startHour = 8;
    int endHour = 9;
    for (int i = 0; i < 5; i++) {
        switch (periodInt) {
            case 1: {
                periodString = @"A";
                break;
            }
            case 2: {
                periodString = @"B";
                break;
            }
            case 3: {
                periodString = @"C";
                break;
            }
            case 4: {
                periodString = @"D";
                break;
            }
            case 5: {
                periodString = @"E";
                break;
            }
            case 6: {
                periodString = @"F";
                break;
            }
            case 7: {
                periodString = @"G";
                periodInt = 0;
                break;
            }
                
            default:
                break;
        }
        NSDateComponents *startComps = [[NSDateComponents alloc] init];
        [startComps setYear:2014];
        [startComps setMonth:6];
        [startComps setDay:30];
        [startComps setHour:startHour];
        [startComps setMinute:15];
        [startComps setSecond:0];
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        startTime = [cal dateFromComponents:startComps];
        NSDateComponents *endComps = [[NSDateComponents alloc] init];
        [endComps setYear:2014];
        [endComps setMonth:6];
        [endComps setDay:30];
        [endComps setHour:endHour];
        [endComps setMinute:45];
        [endComps setSecond:0];
        NSDate *endTime = [cal dateFromComponents:endComps];
        Period *period = [[Period alloc] initWithDetails:periodString withStartTime:startTime withEndTime:endTime withHasPassingTime:NO];
        [self.periods addObject:period];
        periodInt++;
        startHour++;
        endHour++;
    }
    dateString = [dateFormatter stringFromDate:startTime];
    [Global setPeriodsForDay:dateString withPeriods:self.periods]; //sets the periods in the NSDictonary to the periods we just created
}



@end
