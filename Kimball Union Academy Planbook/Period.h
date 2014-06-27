//
//  Period.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/24/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Period : NSObject {

    
}
@property (assign) BOOL *passingTime;
@property (nonatomic, strong) NSString *periodName;
@property (nonatomic, strong) NSDictionary *periodDetails;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
-(id)initWithDetails:(NSString*)name withStartTime:(NSDate*)start withEndTime:(NSDate*)end withHasPassingTime:(BOOL)passing;
@end
