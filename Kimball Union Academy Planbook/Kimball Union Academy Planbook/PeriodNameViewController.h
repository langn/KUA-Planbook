//
//  PeriodNameViewController.h
//  Kimball Union Academy Planbook
//
//  Created by Nathaniel Lang on 1/5/15.
//  Copyright (c) 2015 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeriodNameViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *aPeriodTextField;
@property (weak, nonatomic) IBOutlet UITextField *bPeriodTextField;
@property (weak, nonatomic) IBOutlet UITextField *cPeriodTextField;
@property (weak, nonatomic) IBOutlet UITextField *dPeriodTextField;
@property (weak, nonatomic) IBOutlet UITextField *ePeriodTextField;
@property (weak, nonatomic) IBOutlet UITextField *fPeriodTextField;
@property (weak, nonatomic) IBOutlet UITextField *gPeriodTextField;
@property (weak, nonatomic) IBOutlet UITextField *hPeriodTextField;
- (IBAction)applyButton:(id)sender;
@end
