//
//  OMGHelpAppDelegate.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/23/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "OMGHelpAppDelegate.h"
#import "RootViewController.h"


@implementation OMGHelpAppDelegate

@synthesize window = _window;
@synthesize nvc1;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch  
    /*
    // add subviews to Navigation Controller
    // create array with subviews
    NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    // Root view controller for "Topics list"
    nvc1.tabBarItem.image = [UIImage imageNamed:@"JesusRevIcon.png"];
    nvc1.hidesBottomBarWhenPushed = YES;
    
    // Add navigation controller to the local vc array (1 of 2)
    [localViewControllersArray addObject:nvc1];
    
    // Root view controller for "Information"
    //  nvc2.tabBarItem.image = [UIImage imageNamed:@"JesusRevBW.png"];
    
    // Add navigation controller to the local vc array (2 of 2)
    // [localViewControllersArray addObject:nvc2];
    
    // Point the tab bar controllers view controller array to the array
    // of view controllers we just populated
    tbc.viewControllers = localViewControllersArray;
    [localViewControllersArray release]; // Retained thru above setter
    */
    
    [_window addSubview:[nvc1 view]];
    [_window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
		if ([defaults objectForKey:@"firstTime"]==nil ){
			[defaults setBool:NO forKey:@"firstTime"];
		}
		else {
		}
}


#pragma mark -
#pragma mark Memory management



- (void)applicationWillResignActive:(UIApplication *)application
{

    [self applicationWillTerminate:application];
    exit(0);
}
@end

