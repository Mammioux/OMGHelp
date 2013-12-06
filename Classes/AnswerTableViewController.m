//
//  AnswerTableViewController.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 4/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AnswerTableViewController.h"
#import "CrownViewController.h"
#import "FBConnect.h"
#import "FBStreamDialog.h"
#import "TwitterLoginViewController.h"

@implementation AnswerTableViewController
@synthesize index,player;
@synthesize answer,topic;
@synthesize scrollTextView,webView;
@synthesize muted;
@synthesize circularCounter;
@synthesize waitAwhile;


#pragma mark -
#pragma mark View lifecycle
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"AnswerTableViewController" bundle:nibBundleOrNil]) {
            _session = [[FBSession sessionForApplication:kApiKey secret:kApiSecret delegate:self] retain];
        }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    //     _session = [[FBSession sessionForApplication:kApiKey secret:kApiSecret delegate:self] retain];
	
	// initial values for global variables
	self.circularCounter = 0;
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Custom initialization
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController setToolbarHidden:NO animated:YES];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	self.muted = [defaults boolForKey:@"muted"];
    [self configureToolbarItems];
    
	/**/ 
	NSMutableString *noBlanksTopic = [[NSMutableString alloc] initWithCapacity:[self.topic length]];
	for (int i = 0; i < [self.topic length]; i++) {
		//NSLog(@"character from topic: %C", [self.topic characterAtIndex:i]);
		if ([ [NSCharacterSet letterCharacterSet] characterIsMember:[self.topic characterAtIndex:i] ])
		{
			[noBlanksTopic appendFormat:@"%C", [self.topic characterAtIndex:i] ];
		}//if character is a letter
	}//for all characters in topic
    
    self.scrollTextView.font = [UIFont fontWithName:@"STHeitiK-Medium" size:16];
	//webView.backgroundColor = [UIColor clearColor];
	//scrollTextView.backgroundColor = [UIColor clearColor];
}

- (void)configureToolbarItems

{
	//It may be called a button, but it is really the space between buttons.
	UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc]												
												initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
												target:nil action:nil];
	
	UIBarButtonItem *actionButtonBar = [[UIBarButtonItem alloc]												
										initWithBarButtonSystemItem:UIBarButtonSystemItemAction
										target:self action:@selector(styleAction:)];
    
    UIImage *img = [UIImage imageNamed:@"left_arrow-32.png"];
    
    
	
	UIBarButtonItem *backButtonBar = [[UIBarButtonItem alloc]												
                                      initWithImage:img 
                                      style:UIBarButtonItemStylePlain 
                                      target:self 
                                      action:@selector(previousPage:)];
	
    img = [UIImage imageNamed:@"right_arrow-32.png"];
	
	UIBarButtonItem *nextButtonBar = [[UIBarButtonItem alloc]												
                                      initWithImage:img 
                                      style:UIBarButtonItemStylePlain 
                                      target:self
                                      action:@selector(nextPage:)];
	
    img = muted?[UIImage imageNamed:@"Mute-32.png"]:[UIImage imageNamed:@"Sound-32.png"];           
	
    
	UIBarButtonItem *muteButtonBar = [[UIBarButtonItem alloc]												
									  initWithImage:img
                                      style:UIBarButtonItemStylePlain
									  target:self action: @selector(toggleSound:)];
	
  	// Set our toolbar items
	backButtonBar.tag = 0;
	flexibleSpaceButtonItem.tag = 1;
	actionButtonBar.tag = 2;
	//flexibleSpaceButtonItem,
	muteButtonBar.tag = 3;
	flexibleSpaceButtonItem.tag = 4;
	nextButtonBar.tag = 5;
	//fbButton.tag = 6;
	
	[self setToolbarItems:[NSArray arrayWithObjects:
						   backButtonBar,
						   flexibleSpaceButtonItem,
						   actionButtonBar,	
                           flexibleSpaceButtonItem,
						   muteButtonBar,
						   flexibleSpaceButtonItem,
						   nextButtonBar,
						   nil] animated: YES];	
    [self showQuote];
	//as in case 0 of showCurrentPage, back button is disabled
	UIBarButtonItem *back = [self.toolbarItems objectAtIndex:0];
	back.enabled = NO;
	[flexibleSpaceButtonItem release];	
	[actionButtonBar release];
	[backButtonBar release];
	[nextButtonBar release];
	[muteButtonBar release];
}

-(IBAction)nextPage:(id)sender
{
	self.circularCounter += 1;
	if (self.circularCounter > 3)
	{
		self.circularCounter = 3;
	}
	[self showCurrentPage];
}

-(IBAction)previousPage:(id)sender
{
	self.circularCounter -=1;
	if(self.circularCounter < 0)
	{
	    self.circularCounter = 0;
	}
	[self showCurrentPage];
}	


- (IBAction)showCurrentPage
{
    NSInteger lastIndex = [self.toolbarItems count] -1;
	UIBarButtonItem *back = [self.toolbarItems objectAtIndex:0];
	UIBarButtonItem *next = [self.toolbarItems objectAtIndex:lastIndex];
    switch (circularCounter) {
        case 0:
            [self showQuote];
			//first case: back disdabled, next enabled
			back.enabled = NO;
			//next.enabled = YES;
            break;
        case 1:
            [self showExplanation];
			//middle case: back endabled, next enabled
			back.enabled = YES;
			//next.enabled = YES;
            break;
        case 2:
            [self showGetReal];
			//last case: back endabled, next disabled
			//back.enabled = YES;
			next.enabled = YES;
            break;			
        case 3:
            [self showLinks];
			//middle case: back endabled, next enabled
			//back.enabled = YES;
			next.enabled = NO;
            break;
        default:
			NSLog(@"Current page: %d, circular counter must be wrong", self.circularCounter);
            break;
    }
    
    
}

//the following 4 methods are called by - (IBAction)segmentAction:(id)sender; as needed
- (void) showQuote
{
	NSLog(@"ShowQuote");
	self.navigationItem.title = @"Bible Quote";
	scrollTextView.text = [answer objectForKey:@"bible quote"];
	webView.hidden = YES;
	scrollTextView.hidden = NO;
	NSMutableString *noBlanksTopic = [[NSMutableString alloc] initWithCapacity:[self.topic length]];
	for (int i = 0; i < [self.topic length]; i++) {
		//NSLog(@"character from topic: %C", [self.topic characterAtIndex:i]);
		if ([ [NSCharacterSet letterCharacterSet] characterIsMember:[self.topic characterAtIndex:i] ])
		{
			[noBlanksTopic appendFormat:@"%C", [self.topic characterAtIndex:i] ];
		}//if character is a letter
	}//for all characters in topic
	/**/
	NSString *filename = [[NSString alloc] initWithFormat:@"%@%d", (NSString *)noBlanksTopic , self.index];
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: filename ofType: @"mp3"];
    [filename release];
    //[noBlanksTopic release];
	if (soundFilePath != nil) {
		NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
		if (self.player == nil) {
			NSLog(@"Creating new player");
			AVAudioPlayer *newPlayer = [AVAudioPlayer alloc];
			self.player = newPlayer;
			[newPlayer release];
		} else {
			NSLog(@"Reusing player");
			[self.player stop];
		}
	[self.player initWithContentsOfURL:fileURL error:nil];
		[fileURL release];			
	}
	
    if (self.player != nil) {
        [self.player stop];
        [self.player prepareToPlay];
        [self.player setVolume: 1.0];
        
        if (muted) {
            [self.player pause];
        } else {
            [self.player play];
        }//if muted or else
    }//if player exists
}//showQuote

- (void) showExplanation
{   
	self.navigationItem.title = @"Explanation";
	scrollTextView.text = [answer objectForKey:@"explanation"];
	webView.hidden = YES;
	scrollTextView.hidden = NO;
	[self.player pause];
}

- (void) showGetReal
{
	//UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"prize" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    //[self.navigationItem setRightBarButtonItem:done];
	//[done release];
	self.navigationItem.title = @"Keep it Real";
	scrollTextView.text = [answer objectForKey:@"examples"];
	webView.hidden = YES;
	scrollTextView.hidden = NO;
	[self.player pause];
	
	// only create timer to wait for reading on the first time this page is visited
	if (self.waitAwhile == nil) {
		self.waitAwhile = [NSTimer scheduledTimerWithTimeInterval:8 target:self 
														 selector:@selector(jewelFireMethod:)
														 userInfo:nil repeats:YES];		
	}
}

- (void) showLinks
{
	self.navigationItem.title = @"Links";
	//scrollTextView.text = [[answer objectForKey:@"links"] description];
	webView.hidden = NO;
	scrollTextView.hidden = YES;
	webView.backgroundColor = [UIColor clearColor]; 
	NSString *path = [[NSBundle mainBundle] pathForResource:@"LINKS" ofType:@"html"];
	NSString *resourcePath = [[NSBundle mainBundle] bundlePath];
	NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
	
	NSString *htmlString = [[NSString alloc] initWithData: 
							[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
	
	// to make html content transparent to its parent view -
	// 1) set the webview's backgroundColor property to [UIColor clearColor]
	// 2) use the content in the html: <body style="background-color: transparent">
	// 3) opaque property set to NO
	//
	//aboutPage.opaque = NO;
	//webView.backgroundColor = [UIColor clearColor];
	//scrollTextView.backgroundColor = [UIColor clearColor];
	[self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:resourcePath]];
	
	[self.view sendSubviewToBack:scrollTextView];
	
	[self.player pause];
}

- (IBAction)done:(id)sender {
	
	// Navigation logic may go here. Create and push another view controller.
    self.hidesBottomBarWhenPushed = YES;
	[self.navigationController setToolbarHidden:YES animated:YES];
	CrownViewController *crownViewController = [[CrownViewController alloc] initWithNibName:@"CrownViewController" bundle:nil];
	// Pass the selected object to the answerViewController.
	UIBarButtonItem *customBack = [[UIBarButtonItem alloc] initWithTitle:@"iDialJesus" 
																   style:UIBarButtonItemStyleDone 
																  target:nil action:NULL ];
	self.navigationController.navigationItem.backBarButtonItem = customBack;
    [customBack release];
	
    [self.navigationController pushViewController:crownViewController animated:YES];
	
    [crownViewController release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if ([alertView.title compare:@"Closing iDialJesus"] == NSOrderedSame) {
		//[[UIApplication sharedApplication] terminateWithSuccess];	
	}
}

- (void)jewelFireMethod:(NSTimer*)theTimer
{    
	//timer no longer needed
    NSLog(@"Killing timer");
	[theTimer invalidate];
	theTimer = nil;
	//show done button
	UIBarButtonItem *doneButtonBar = [[UIBarButtonItem alloc]
									  initWithTitle:@"Prize"
									  style:UIBarButtonItemStyleDone
									  target:self
									  action:@selector(done:)];
	self.navigationItem.rightBarButtonItem = doneButtonBar;
	[doneButtonBar release];
    //play magic wand sound
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"Magic Wand Noise" ofType: @"mp3"];
	if (soundFilePath != nil) {
		NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
        //[soundFilePath release];
		AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
																		  error: nil];
		[fileURL release];
		
		//self.player = newPlayer;
        newPlayer.numberOfLoops = 0;
		newPlayer.delegate = self;
		//[newPlayer prepareToPlay];
		[newPlayer setVolume: 0.4];
		if(!muted){
            [newPlayer play];
        }//if we are not muted 
		//[newPlayer release];
    }//if sound file was found
	//[theTimer invalidate];
}//jewel fire method

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	[self.player stop];
}
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark -
#pragma mark UIResponder

//Override this method in the controller class.
// Hide cut/copy/paste menu

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
	
	if ( [UIMenuController sharedMenuController] )
	{
		[UIMenuController sharedMenuController].menuVisible = NO;
	}
	return NO;
	
}

- (IBAction)toggleSound:(id)sender
{
   	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	muted = !muted;
	[defaults setBool:muted forKey:@"muted"];
	
	if(!muted) {
		[self.player play];
	}
	else       {
		[self.player stop];
	}
	
	[self configureToolbarItems];
    
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Change the navigation bar style, also make the status bar match with it
	switch (buttonIndex)
	{
		case 0:
		{
            
			// send this answer as an email
			NSLog(@"Send email");
            
            Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
            if (mailClass != nil)
            {
                // We must always check whether the current device is configured for sending emails
                if ([mailClass canSendMail])
                {
                    [self displayComposerSheet];
                }
                else
                {
                    [self launchMailAppOnDevice];
                }
            }
            else
            {
                [self launchMailAppOnDevice];
            }
			break;
		}
		case 3:
		{
			// post this answer on Facebook
			NSLog(@"post on FB");
            _session = [FBSession sessionForApplication:@"99d9523b9c944dc7fc25c979a461dd28" secret:@"bad4f5bcd1db752bb9955a267ecd9913" delegate:self];
            FBLoginDialog* dialog = [[[FBLoginDialog alloc] initWithSession:_session] autorelease]; 
            [dialog show];

			break;
		}
		case 2:
		{
			// bookmark this answer
			NSLog(@"Twitter");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *twitterId = [defaults valueForKey:@"twitterID"];
            NSString *twitterPwd = [defaults valueForKey:@"twitterPwd"];

            if ((twitterId == nil) || (twitterPwd == nil)) {
                [self loginTwitterId:twitterId withPwd:twitterPwd];
            }
            
			break;
		}
		case 1:
		{
			// show music page
			NSLog(@"Show Music page and play song");
			self.navigationItem.title = @"Music";
			NSString *htmlString = @"<html><bodystyle=\"background-color: transparent\">Go To www.cdbaby.com/cd/shafer to download the featured song, Renewal, on this app from artist Drew Shafer's CD entitled Sincerely Jesus.</body></html>";
			webView.hidden = NO;
			scrollTextView.hidden = YES;
            webView.backgroundColor = [UIColor clearColor]; 
            

            [self.webView loadHTMLString:htmlString baseURL:nil];
            
            [self.view sendSubviewToBack:scrollTextView];
            
			NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"Renewal" ofType: @"mp3"];
			if (soundFilePath != nil) {
				NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
				if (self.player != nil) {
					[self.player stop];	
					[self.player initWithContentsOfURL: fileURL error: nil];
					[fileURL release];					
					self.player.numberOfLoops = 0;
					[self.player prepareToPlay];
					[self.player setVolume: 0.8];
					if(!muted){
						[self.player play];
					}//if we are not muted 
				}
			}//if sound file was found
			
			break;
		}
	}
}

-(void) loginTwitterId: (NSString *)twitterId withPwd: (NSString *)twitterPwd
{
    // show Twitter login screen.
    TwitterLoginViewController *tweet = [[TwitterLoginViewController alloc] initWithNibName:@"TwitterLoginViewController" bundle:nil];
    [self.navigationController presentViewController:tweet animated:YES];
    [tweet release];    
    
}


#pragma mark -
#pragma mark API

- (IBAction)styleAction:(id)sender
{
	UIActionSheet *styleAlert = [[UIActionSheet alloc] initWithTitle:@"Share this answer with others:"
															delegate:self cancelButtonTitle:@"Cancel"
											  destructiveButtonTitle:nil
												   otherButtonTitles:	@"email",
								 //@"FB",
								 //@"Twitter",
								 @"music",
								 nil];
	
	// use the same style as the nav bar
	styleAlert.actionSheetStyle = self.navigationController.navigationBar.barStyle;
	[styleAlert showInView:self.view.window];
	[styleAlert release];
}

#pragma mark -
#pragma mark AVAudioPlayer delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)mPlayer successfully:(BOOL)flag{
    NSLog(@"Player stopped");
}

#pragma mark -
#pragma mark FB
///////////////////////////////////////////////////////////////////////////////////////////////////
// FBDialogDelegate

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError*)error {
    //  _label.text = [NSString stringWithFormat:@"Error(%d) %@", error.code,
    //                error.localizedDescription];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// FBSessionDelegate

- (void)session:(FBSession*)session didLogin:(FBUID)uid {

    NSLog(@"User with id %lld logged in.", uid);
    
FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease]; 
    dialog.delegate = self; 
    dialog.userMessagePrompt = @"Example prompt"; 
    dialog.attachment = @"{\"name\":\"Facebook iPhone SDK\" ",
                         "\"href\":\"http://developers.facebook.com/connect.php?tab=iphone\" ",
                         "\"caption\":\"Caption\",\"description\":\"Description\"," "\"media\":[{\"type\":\"image\"," "\"src\":\"http://img40.yfrog.com/img40/5914/iphoneconnectbtn.jpg\"," "\"href\":\"http://developers.facebook.com/connect.php?tab=iphone/\"}]," "\"properties\":{\"another link\":{\"text\":\"Facebook home page\",\"href\":\"http://www.facebook.com\"}}}"; 
    // replace this with a friend's UID 
    dialog.targetId = @"trios1@yahoo.com"; 
    [dialog show];
}

- (void)sessionDidLogout:(FBSession*)session {
    // _label.text = @"";
    //_permissionButton.hidden = YES;
    //_feedButton.hidden = YES;
    NSLog(@"FBSession Logged out");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// FBRequestDelegate

- (void)request:(FBRequest*)request didLoad:(id)result {
    NSArray* users = result;
    NSDictionary* user = [users objectAtIndex:0];
    NSString *fbname = [user objectForKey:@"name"];
    NSLog(@"%@",[NSString stringWithFormat:@"Logged in as %@", fbname]);
}

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error {
    // _label.text = [NSString stringWithFormat:@"Error(%d) %@", error.code,
    //                error.localizedDescription];
    // The user canceled -- simply dismiss the image picker.
	[self dismissModalViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)askPermission:(id)target {
    FBPermissionDialog* dialog = [[[FBPermissionDialog alloc] init] autorelease];
    dialog.delegate = self;
    dialog.permission = @"status_update";
    [dialog show];
}


- (void)publishFeed:(id)target {
    FBDialog* dialog = [[[FBDialog alloc] init] autorelease];
    dialog.delegate = self;
    //dialog.templateBundleId = 123951283284; //one line template
    // dialog.templateBundleId = 124423393284; // short story template
    //NSString *tempData = [NSString stringWithFormat:@"{\"key1\": \"value1\",\"offer\": \"%@\",\"items\": \"lots of things\"}",[self.answer objectForKey:@"bible quote"]];
	//    dialog.templateData = @"{\"key1\": \"value1\",\"offer\": \"bigdeal\",\"items\": \"lots of things\"}";
    //dialog.templateData =tempData;
    [dialog show];
}

#pragma mark -
#pragma mark MFMailComposeViewController
// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
    NSString *question = [answer objectForKey:@"question"];
	[picker setSubject:question];
	
    
	// Set up recipients
	NSArray *toRecipients = nil; 
	
	[picker setToRecipients:toRecipients];
	
	// Attach an image to the email
	NSString *path = [[NSBundle mainBundle] pathForResource:@"JesusRevIcon" ofType:@"png"];
    NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
	
	// Fill out the email body text
	NSString *emailBody = [answer objectForKey:@"bible quote"];
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	//message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			//message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			//message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			//message.text = @"Result: failed";
			break;
		default:
			//message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:%20&subject=Hello from California!";
	NSString *body = [answer objectForKey:@"bible quote"];
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    NSLog(@"Received Memory Warning");
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[self.player stop];
}


- (void)dealloc {
    [player release];
    [answer release];
    [topic  release];
    [scrollTextView release];
    //[_session.delegates removeObject: self]; 
    [super dealloc];
}


@end

