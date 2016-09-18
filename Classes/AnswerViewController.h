//
//  AnswerTableViewController.h
//  iDialJesus
//
//  Created by Teresa Rios-Van Dusen on 4/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "QuestionViewController.h"

@class FBSession;

@interface AnswerViewController : UIViewController < UIActionSheetDelegate,
                                                          MFMailComposeViewControllerDelegate,
                                                          AVAudioPlayerDelegate, UISplitViewControllerDelegate, QuestionDelegate >

@property (nonatomic, readwrite) NSInteger index;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioPlayer *prizes;
@property (nonatomic, strong) NSDictionary *answer;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, strong) IBOutlet UITextView *scrollTextView;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, readwrite) BOOL muted;
@property (nonatomic,readwrite) int circularCounter;
@property (nonatomic, strong) NSTimer *waitAwhile;

- (IBAction)toggleSound:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)nextPage:(id)sender;
- (IBAction)previousPage:(id)sender;
- (IBAction)styleAction:(id)sender;

- (IBAction)showCurrentPage;

- (void) configureToolbarItems;
- (void) showQuote;
- (void) showExplanation;
- (void) showGetReal;
- (void) showLinks;

- (void)jewelFireMethod:(NSTimer*)theTimer;

- (void) actionMail;
- (void) actionFaceBook;
- (void) actionTwitter;
- (void) actionMusic;

-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
-(void)loginTwitterId: (NSString *)twitterId withPwd: (NSString *)twitterPwd;

@end
