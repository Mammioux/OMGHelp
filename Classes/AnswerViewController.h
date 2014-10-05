//
//  AnswerTableViewController.h
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 4/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class FBSession;

@interface AnswerViewController : UIViewController < UIActionSheetDelegate,
                                                          MFMailComposeViewControllerDelegate,
                                                          AVAudioPlayerDelegate>
{

	int index;
    AVAudioPlayer *player;
    AVAudioPlayer *prizes;
	NSDictionary *answer;
	NSString *topic;
	NSTimer *waitAwhile;
    UITextView *scrollTextView;
	UIWebView *webView;
    BOOL  muted;
	int circularCounter;
    FBSession * __session;
    
    //UIImageView *imageView;
    //UISegmentedControl *segmentedControl;
}

@property (nonatomic, readwrite) int index;
@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSDictionary *answer;
@property (nonatomic, retain) NSString *topic;
@property (nonatomic, retain) IBOutlet UITextView *scrollTextView;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, readwrite) BOOL muted;
@property (nonatomic,readwrite) int circularCounter;
@property (nonatomic, retain) NSTimer *waitAwhile;

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
