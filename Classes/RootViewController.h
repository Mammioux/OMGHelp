//
//  RootViewController.h
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/23/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QuestionViewController;
@class Disclaimer;

#define SECONDS_IN_A_DAY 86400

@interface RootViewController : UITableViewController <UIAlertViewDelegate>
{
	NSArray *data;
	UIBarButtonItem *rightBarButtonItem;
	NSArray *jewelery;
}
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) NSArray *jewelery;

- (void)done:(id)sender; 

@end
