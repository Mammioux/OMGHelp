//
//  QuestionViewController.h
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnswerViewController;

@interface QuestionViewController : UITableViewController {
	NSArray *questions;
	NSString *topic;
	AnswerViewController * iv; // information value
}

@property (nonatomic, retain) NSArray *questions;
@property (nonatomic, retain) NSString *topic;
@end
