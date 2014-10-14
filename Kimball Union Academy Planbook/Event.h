//
//  Event.h
//  Kimball Union Academy Planbook
//
//  Created by Nathaniel Lang on 10/14/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Period;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) Period *onPeriod;

@end
