//
//  Tester.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/23/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group.h"
#import  "User.h"
#import "Period.h"
#import "Global.h" //might break everything

@interface Tester : NSObject {
    Group *group1;
    Group *group2;
    User *user1;
    User *user2;
    int periodInt;
    NSString *periodString;
    NSDate *startTime;
    NSString *dateString;
    NSDateFormatter *dateFormatter;
}
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, weak) NSMutableArray *users;
@property (nonatomic, strong) NSMutableArray *periods;
//@property (nonatomic, weak) NSDate *startTime;
//@property (nonatomic, weak) NSDate *endTime;
-(void)initGroups;
-(void)initUsers;
-(void)initDay1;
-(void)initDay2;
-(void)initDay3;
-(void)initDay4;
-(void)initDay5;
@end
