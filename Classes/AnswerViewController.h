//
//  answerViewController.h
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/26/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface AnswerViewController : UIViewController <UITabBarDelegate> {
	
	int index;
    AVAudioPlayer *player;
	NSDictionary *answer;
	UITextView *scrollTextView;
}

@property (nonatomic, readwrite) int index;
@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSDictionary *answer;
@property (nonatomic, retain) IBOutlet UITextView *scrollTextView;

- (IBAction)toggleView:(id)sender;
- (void) configureToolbarItems;
- (void) showQuote;
- (void) showExplanation;
- (void) showGetReal;
- (void) showLinks;

@end