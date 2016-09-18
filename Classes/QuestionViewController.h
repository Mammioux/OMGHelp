//
//  QuestionViewController.h
//  iDialJesus
//
//  Created by Teresa Rios-Van Dusen on 3/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QuestionDelegate <NSObject>

-(void) didSelectQuestion:(NSDictionary *) answer;

@end

@interface QuestionViewController : UITableViewController <UISplitViewControllerDelegate> 



@property (nonatomic,strong) id<QuestionDelegate> delegate;

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) IBOutlet UIStoryboardSegue *showSegue;
@end
