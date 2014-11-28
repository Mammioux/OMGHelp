//
//  OMGHelpAppDelegate.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/23/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "IDialJesusAppDelegate.h"
#import "RootViewController.h"
#import "AnswerViewController.h"

@interface IDialJesusAppDelegate () <UISplitViewControllerDelegate>

@end


@implementation IDialJesusAppDelegate

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
    
    // Override point for customization after application launch.
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
       
        if ([[UIDevice currentDevice].systemVersion compare:@"8.0"] == NSOrderedAscending ) {
            navigationController.topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Categories" style:UIBarButtonItemStylePlain target:self
                                                                                                                      action: @selector(splitViewController:collapseSecondaryViewController:ontoPrimaryViewController:)];
        } else {
            navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
        }
        splitViewController.delegate = self;
    } else {
        [_window addSubview:[nvc1 view]];
        [_window makeKeyAndVisible];
    }
    
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game
    [self applicationWillTerminate:application];
    exit(0);

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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


#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[AnswerViewController class]] && ([(AnswerViewController *)[(UINavigationController *)secondaryViewController topViewController] answer] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}


@end

