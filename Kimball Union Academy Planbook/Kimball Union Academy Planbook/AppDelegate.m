//
//  AppDelegate.m
//  Kimball Union Academy Planbook
//
//  Created by iD Student on 6/21/14.
//  Copyright (c) 2014 Nate Lang. All rights reserved.
//

#import "AppDelegate.h"
#import "Global.h"
#import <Parse/Parse.h>

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentationDirectory inDomains:NSUserDomainMask] firstObject];
    NSString *documentName = @"PeriodStorage";
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                [self documentIsReady];
            }
            if (!success ) {
                NSLog(@"Was not able to open document with url %@", url);
            }
        }];
        
    }
    else {
        [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [self documentIsReady];
            }
            if (!success) {
                NSLog(@"Was not able to open document with url %@", url);
            }
        }];
    }
    
    
    [Global loadTester];
    [Global loadDayScrollView];
    [Global loadDayViewController];
    //[Parse setApplicationId:@"xivEDSWrAII34eY25ve6gfyMsRdyHDGnjVkbLpLN"
                  //clientKey:@"fLGsb6F7AzkPmc7y229byKkZIGhXXPzAnTs1ZHOs"]; //PARSE CODE: NEED THIS FOR PARSE TO WORK
    //[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)documentIsReady { //going to need to read in database stuff in here eventually depending on whether or not the data is there
    if (self.document.documentState == UIDocumentStateNormal) {
        
        self.context = self.document.managedObjectContext;
        DayView *dayView = [[DayView alloc] init];
        
        
        Period *period = [NSEntityDescription insertNewObjectForEntityForName:@"Period" inManagedObjectContext:self.context];
        
        //following code is for testing whether this works or not, delete later and replace with JSON init
        
        NSString* dateString1 = @"08052014T08:00";
        NSString* dateString2 = @"08052014T09:00";
        NSString* dateString3 = @"08052014T10:30";
        NSString* dateString4 = @"08052014T11:00";
        NSString* dateString5 = @"08052014T11:15";
        NSString* dateString6 = @"08052014T12:00";
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMddyyyy'T'HH':'mm"];
        
        NSDate* date1 = [[NSDate alloc] init];
        NSDate* date2 = [[NSDate alloc] init];
        NSDate* date3 = [[NSDate alloc] init];
        NSDate* date4 = [[NSDate alloc] init];
        NSDate* date5 = [[NSDate alloc] init];
        NSDate* date6 = [[NSDate alloc] init];
        
        date1 = [dateFormatter dateFromString:dateString1];
        date2 = [dateFormatter dateFromString:dateString2];
        date3 = [dateFormatter dateFromString:dateString3];
        date4 = [dateFormatter dateFromString:dateString4];
        date5 = [dateFormatter dateFromString:dateString5];
        date6 = [dateFormatter dateFromString:dateString6];
        
        period.title = @"A";
        period.startTime = date1;
        period.endTime = date2;
        
        //save the context
        
        
    }
}

@end
