//
//  PeriodNameViewController.m
//  Kimball Union Academy Planbook
//
//  Created by Nathaniel Lang on 1/5/15.
//  Copyright (c) 2015 Nate Lang. All rights reserved.
//

#import "PeriodNameViewController.h"

@interface PeriodNameViewController  ()

@end

@implementation PeriodNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.aPeriodTextField setDelegate:self];
    [self.bPeriodTextField setDelegate:self];
    [self.cPeriodTextField setDelegate:self];
    [self.dPeriodTextField setDelegate:self];
    [self.ePeriodTextField setDelegate:self];
    [self.fPeriodTextField setDelegate:self];
    [self.gPeriodTextField setDelegate:self];
    [self.hPeriodTextField setDelegate:self];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applyButton:(id)sender { //set the user defaults for the custom names of periods
    [[NSUserDefaults standardUserDefaults] setObject:self.aPeriodTextField.text forKey:@"aPeriodTitle"];
    [[NSUserDefaults standardUserDefaults] setObject:self.bPeriodTextField.text forKey:@"bPeriodTitle"];
    [[NSUserDefaults standardUserDefaults] setObject:self.cPeriodTextField.text forKey:@"cPeriodTitle"];
    [[NSUserDefaults standardUserDefaults] setObject:self.dPeriodTextField.text forKey:@"dPeriodTitle"];
    [[NSUserDefaults standardUserDefaults] setObject:self.ePeriodTextField.text forKey:@"ePeriodTitle"];
    [[NSUserDefaults standardUserDefaults] setObject:self.fPeriodTextField.text forKey:@"fPeriodTitle"];
    [[NSUserDefaults standardUserDefaults] setObject:self.gPeriodTextField.text forKey:@"gPeriodTitle"];
    [[NSUserDefaults standardUserDefaults] setObject:self.hPeriodTextField.text forKey:@"hPeriodTitle"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField text] != nil) {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
