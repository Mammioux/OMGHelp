//
//  QuestionViewController.h
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QuestionDelegate <NSObject>

-(void) didSelectQuestion:(NSDictionary *) answer;

@end

@interface QuestionViewController : UITableViewController <UISplitViewControllerDelegate> {
	NSArray *questions;
	NSString *topic;
}

@property (nonatomic,retain) id<QuestionDelegate> delegate;

@property (nonatomic, retain) NSArray *questions;
@property (nonatomic, retain) NSString *topic;
@property (nonatomic, retain) UIFont *font;
@end
