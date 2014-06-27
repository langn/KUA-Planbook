//
//  HomeViewController.h
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/21/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"
#import "UIView+AutoLayout.h"
#import "Tester.h"
#import "Global.h"

@interface HomeViewController : UIViewController
//outlet for the skview so that we can access it for the particle effects
@property IBOutlet SKView *skView;
//outlets for the buttons so that we can change their constraints
@property (weak, nonatomic) IBOutlet UIButton *viewTodayButton;
@property (weak, nonatomic) IBOutlet UIButton *overviewButton;
@property (weak, nonatomic) IBOutlet UIButton *notificationsButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (strong, nonatomic) Tester *tester;
@end
