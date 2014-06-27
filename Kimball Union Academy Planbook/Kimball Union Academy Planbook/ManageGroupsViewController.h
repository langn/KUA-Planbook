//
//  ManageGroupsViewController.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/23/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupTableView.h"

@interface ManageGroupsViewController : UIViewController
    

@property (strong, nonatomic) IBOutlet GroupTableView *groupsTable;
- (IBAction)addGroup:(id)sender;
- (IBAction)removeGroup:(id)sender;
- (IBAction)createGroup:(id)sender;
@end