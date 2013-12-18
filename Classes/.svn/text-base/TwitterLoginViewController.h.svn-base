//
//  TwitterLoginViewController.h
//  iDialJesus
//
//  Created by Teresa Rios-Van Dusen on 5/31/10.
//  Copyright 2010 iDialJesus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterRequest;

@interface TwitterLoginViewController : UIViewController <UITextFieldDelegate>{
    UITextField *tuid;
    UITextField *tpwd;
    NSString    *quote;
    TwitterRequest *t;
    UIActionSheet *loadingActionSheet;

}
@property (nonatomic, retain) IBOutlet UITextField *tuid;
@property (nonatomic, retain) IBOutlet UITextField *tpwd;
@property (nonatomic, retain) NSString *quote;
@property (nonatomic, retain) TwitterRequest *t;


- (IBAction) postTweet: (id) sender ;

@end
