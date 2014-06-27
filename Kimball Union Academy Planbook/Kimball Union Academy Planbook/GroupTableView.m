//
//  GroupTableView.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/23/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "GroupTableView.h"


@implementation GroupTableView


- (id)init //default constuctor, we don't use this becuase storyboard does it for us
{
    //makes a tester object so that we can access the groups property
    //tester = [HomeViewController.tester];
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)prepareForTableView { //prepares the things so that tableview works
        //init table view
        [self setDelegate:self]; //sets tableview delegate to self so we have access to the methods below
        [self setDataSource:self]; //sets table datasource to self so we have access to the methods below
        tester = [Global tester]; //copies the global tester variable so that we can access it

}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{ //number of sections in the table view, in this case should be one
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { //number of rows per section (1 section) is = the number of groups in the groups array
    return [tester.groups count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"groupCell"; //String for the storyboard ID of the cell
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(cellIdentifier) forIndexPath:(indexPath)]; //makes a cell following the template
    Group *groupForThisCell = [tester.groups objectAtIndex:[indexPath row]]; //takes the group out of the groups array at the row index
    [cell.groupLabel setText:[groupForThisCell name]]; //changes the label of the cell to display the name of the group
    return cell; //returns the cell and draws it
}
    

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
