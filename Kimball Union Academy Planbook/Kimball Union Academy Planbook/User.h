//
//  User.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/23/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
-(id)initWithParameters:(NSString*)userNameParam withGroups:(NSMutableArray*)groupsParam withClassYear:(int)classYearParam;
    @property(nonatomic, weak)NSString *name;
    @property(nonatomic, weak)NSMutableArray *groups;
    @property(nonatomic, assign)int classYear;
@end
