//
//  Period.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/24/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "Period.h"

@implementation Period

/*-(id)initWithDetails:(NSString*)name withStartTime:(NSCalendar*)start withEndTime:(NSCalendar*)end withHasPassingTime:(NSNumber*)passing{
    self.periodDetails = [[NSDictionary alloc] init];
    self.periodDetails = @{@"periodName" : name, @"startTime" : start, @"endTime" : end, @"passingTime" : passing};
    return self;
}*/
-(id)initWithDetails:(NSString*)name withStartTime:(NSDate*)start withEndTime:(NSDate*)end withHasPassingTime:(BOOL)passing{
    self.periodName = name;
    self.startTime = start;
    self.endTime = end;
    self.passingTime = &(passing);
    return self;
}


@end
