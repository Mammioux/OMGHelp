//
//  iDialJesusAppDelegate.m
//  iDialJesus
//
//  Created by Teresa Rios-Van Dusen on 3/23/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "IDialJesusAppDelegate.h"
#import "RootViewController.h"
#import "AnswerViewController.h"

@interface IDialJesusAppDelegate () 

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
        RootViewController * rootViewController = (RootViewController *)[[splitViewController.viewControllers objectAtIndex:0] topViewController];
        UINavigationController *nvc = [splitViewController.viewControllers objectAtIndex:0];
        _detailvc = (AnswerViewController*)[[splitViewController.viewControllers lastObject] topViewController];
        _detailvc.topic = @"NoTopic";
        _detailvc.index = 0;
        NSString *dataPath     = [[NSBundle mainBundle] pathForResource:@"NoTopic"   ofType:@"plist"];
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:dataPath];
        _detailvc.answer = data;

        // NsLog(@"System Version: %@", [UIDevice currentDevice].systemVersion);
        rootViewController.navigationItem.title = @"Categories";
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 ) {
           nvc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Categories" style:UIBarButtonItemStylePlain target:_detailvc
                                                                                                                      action: @selector(splitViewController:collapseSecondaryViewController:ontoPrimaryViewController:)];
        } else {
            // NsLog(@"display mode button Item: %@", splitViewController.displayModeButtonItem.title);
            
            nvc.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
            nvc.navigationItem.leftBarButtonItem.title = @"Categories";
        }
        // NsLog(@"Class of last Object %@", [[splitViewController.viewControllers lastObject] class] );
        splitViewController.delegate = _detailvc;
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


@end

