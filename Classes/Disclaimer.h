//
//  Disclaimer.h
//  iDialJesus
//
//  Created by Teresa Rios-Van Dusen on 4/11/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class QuestionViewController;

@interface Disclaimer : UIViewController {
    UITextView *disc;
	
}

@property (nonatomic, retain) IBOutlet UITextView *disc;

- (IBAction)agree:(id)sender;
- (IBAction) info:(id)sender;


@end
