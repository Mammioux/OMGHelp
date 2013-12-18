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

@interface AnswerTableViewController : UIViewController {

	int index;
    AVAudioPlayer *player;
	NSDictionary *answer;
    UITextView *scrollTextView;
    BOOL  muted;
    UIButton *doneButton;
	
}

@property (nonatomic, readwrite) int index;
@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSDictionary *answer;
@property (nonatomic, retain) IBOutlet UITextView *scrollTextView;
@property (nonatomic, retain) IBOutlet UIButton *doneButton;
@property (nonatomic, readwrite) BOOL muted;

- (IBAction)toggleSound:(id)sender;
- (IBAction)done:(id)sender;
- (void) configureToolbarItems;
- (void) showQuote;
- (void) showExplanation;
- (void) showGetReal;
- (void) showLinks;

@end
