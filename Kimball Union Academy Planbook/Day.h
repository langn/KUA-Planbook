//
//  Day.h
//  Kimball Union Academy Planbook
//
//  Created by Nathaniel Lang on 11/5/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Period;

@interface Day : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *withPeriods;
@end

@interface Day (CoreDataGeneratedAccessors)

- (void)addWithPeriodsObject:(Period *)value;
- (void)removeWithPeriodsObject:(Period *)value;
- (void)addWithPeriods:(NSSet *)values;
- (void)removeWithPeriods:(NSSet *)values;

@end
