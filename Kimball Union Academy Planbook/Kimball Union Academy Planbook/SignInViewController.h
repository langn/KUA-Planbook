//
//  SignInViewController.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/24/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)needHelpButton:(id)sender;
@end
