//
//  User.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/23/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "User.h"

@implementation User
-(id)initWithParameters:(NSString*)userNameParam withGroups:(NSMutableArray*)groupsParam withClassYear:(int)classYearParam {
    [self setName:userNameParam];
    [self setGroups:groupsParam];
    [self setClassYear:classYearParam];
    return self;
}
@end
