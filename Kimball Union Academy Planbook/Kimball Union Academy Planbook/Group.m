//
//  Group.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/23/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "Group.h"

@implementation Group
-(id)initWithParameters:(NSString*)groupName withUsers:(NSMutableArray*)usersArray withRegularPeriodBool:(BOOL)regularPeriodBoolParam withRegularPeriod:(NSString*)regularPeriodStringParam  {
    [self setName:groupName];
    [self setRegularPeriodBool:regularPeriodBoolParam];
    [self setRegularPeriodString:regularPeriodStringParam];
    [self setUsers:usersArray];
    [self setNumberOfMembers:[self.users count]];
    return self;
}

-(void)createGroup{
    
}

@end
