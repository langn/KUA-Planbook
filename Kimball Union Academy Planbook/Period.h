//
//  Period.h
//  Kimball Union Academy Planbook
//
//  Created by Nathaniel Lang on 11/5/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day, Event;

@interface Period : NSManagedObject

@property (nonatomic, retain) NSString * classTitle;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Day *inDay;
@property (nonatomic, retain) Event *withEvent;

@end
