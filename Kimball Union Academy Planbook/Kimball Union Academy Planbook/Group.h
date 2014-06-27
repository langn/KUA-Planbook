//
//  Group.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/23/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject
-(id)initWithParameters:(NSString*)groupName withUsers:(NSMutableArray*)usersArray withRegularPeriodBool:(BOOL)regularPeriodBoolParam withRegularPeriod:(NSString*)regularPeriodStringParam;
@property(nonatomic, weak) NSString *name;
@property(nonatomic, weak) NSString *regularPeriodString;
@property(nonatomic, weak) NSMutableArray *users;
@property(nonatomic, assign) BOOL regularPeriodBool;
@property(nonatomic, assign) int numberOfMembers;

@end
