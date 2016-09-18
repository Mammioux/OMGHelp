//
//  IDialJesusAppDelegate.h
//  iDialJesus
//
//  Created by Teresa Rios-Van Dusen on 3/23/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnswerViewController;
@interface IDialJesusAppDelegate : UIResponder <UIApplicationDelegate>
//{
//    
//    UIWindow *window;
//    UINavigationController *nvc1;
//}

//@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *nvc1;
@property (nonatomic, retain) IBOutlet AnswerViewController *detailvc;
@end

