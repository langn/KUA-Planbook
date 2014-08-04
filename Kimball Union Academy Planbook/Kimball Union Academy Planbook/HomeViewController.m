//
//  ViewController.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/21/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void) viewWillAppear:(BOOL)animated  {
    [super viewDidLoad];
    
    // Configure the SKView
    SKView * skView = _skView;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Configure the SKView
    SKView * skView = _skView;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    [self.navigationController.navigationBar setBarTintColor:([UIColor whiteColor])];
    [self.navigationController.view setBackgroundColor:([UIColor whiteColor])];
    [self.view setBackgroundColor:([UIColor whiteColor])];
    //[self distributeButtons]; //commented out becuase the distribute buttons is not working properly right now
    
    //initializes a tester object with the given variables for testing purposes
    self.tester = [Global tester];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)distributeButtons {
    NSArray *subviews = @[self.viewTodayButton, self.overviewButton, self.notificationsButton, self.signInButton, self.settingsButton];
    NSArray *retVals = [subviews autoDistributeViewsAlongAxis:ALAxisVertical withFixedSize:50.0f alignment:NSLayoutFormatAlignAllCenterX];
}
/*
-(void)updateViewConstraints {
    [super updateViewConstraints];
}

*/

@end
