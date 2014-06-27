//
//  PeriodTableViewCell.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/25/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tester.h"
#import "Global.h"

@interface PeriodTableViewCell : UITableViewCell {
    Tester *tester;
    NSMutableArray *periods;
    int totalSize;
}
@end
