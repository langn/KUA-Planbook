//
//  GroupTableView.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/23/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupTableViewCell.h"
#import "Tester.h"
#import "Global.h"

@interface GroupTableView : UITableView <UITableViewDelegate, UITableViewDataSource> {
    Tester *tester;

}
-(void)prepareForTableView;
@end
