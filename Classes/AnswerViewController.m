//
//  answerViewController.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/26/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AnswerViewController.h"
#import "tabViewController.h"


@implementation AnswerViewController
@synthesize index,player;
@synthesize answer, scrollTextView;

//It will call the list of questions for the selected topic


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.hidesBottomBarWhenPushed = NO;
		[self.navigationController setToolbarHidden:NO animated:YES];
		//[self configureToolbarItems];
		
		 }
		 
	return self;
}

- (void)configureToolbarItems

{
	UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc]												
												initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
												target:nil action:nil];
    // "Segmented" control to the right
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                            [NSArray arrayWithObjects:
                                             @"Jesus says",
                                             @"Explain",
                                             @"Get Real",
                                             @"links",
                                             nil]];
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.frame = CGRectMake(0, 0, 180, 30.0);
	//segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.momentary = YES;
	
	//UIColor *defaultTintColor = [segmentedControl.tintColor retain];	// keep track of this for later
    
	UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    [segmentedControl release];
   /* 
	UIBarButtonItem *quoteButtonItem = [[UIBarButtonItem alloc]												
									   initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
									   target:self action:@selector(toggleView:)];
	quoteButtonItem.tag	= 0;
	
	
	UIBarButtonItem *explanationButtonItem = [[UIBarButtonItem alloc]												
										initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
											  target:self action:@selector(toggleView:)];
	explanationButtonItem.tag = 1;
	
	UIBarButtonItem *getRealButtonItem = [[UIBarButtonItem alloc]												
										initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
										target:self action:@selector(toggleView:)];
	getRealButtonItem.tag = 2;
	
	UIBarButtonItem *linksButtonItem = [[UIBarButtonItem alloc]												
										initWithBarButtonSystemItem:UIBarButtonSystemItemAction
										target:self action:@selector(toggleView:)];
	linksButtonItem.tag = 3;
	*/
	// Set our toolbar items	
	[self setToolbarItems:[NSArray arrayWithObjects:						 
						   flexibleSpaceButtonItem,						 
						   segmentBarItem,	
						   flexibleSpaceButtonItem,	
						   nil] animated: YES];	
	
	[segmentBarItem release];
	[flexibleSpaceButtonItem release];	
}

- (IBAction)toggleView:(id)sender {
	NSLog(@"Showing tab: %@",sender);
	UIBarButtonItem *button = sender;
	switch (button.tag) {
		case 0:
			[self showQuote];
			break;
		case 1:
			[self showExplanation];
			break;
		case 2:
			[self showGetReal];
			break;			
		case 3:
			[self showLinks];
			break;
		default:
			break;
	}
}

- (void) showQuote
{
	scrollTextView.text = [answer objectForKey:@"bible quote"];
	[self.player stop];
	[self.player prepareToPlay];
    [self.player setVolume: 1.0];
    [self.player play];
}
- (void) showExplanation
{
	scrollTextView.text = [answer objectForKey:@"explanation"];
}
- (void) showGetReal
{
	scrollTextView.text = [answer objectForKey:@"examples"];
}
- (void) showLinks
{
	scrollTextView.text = [[answer objectForKey:@"links"] description];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];   
    
	scrollTextView.text = [answer objectForKey:@"bible quote"];
	NSString *filename = [[NSString alloc] initWithFormat:@"answer%d",self.index]; 
	
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: filename
                                                              ofType: @"aiff"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                                      error: nil];
    [fileURL release];
    
    self.player = newPlayer;
    [newPlayer release];
    
    [self.player prepareToPlay];
    [self.player setVolume: 1.0];
    [self.player play];
    
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewWillAppear:(BOOL)animated
{
	self.hidesBottomBarWhenPushed = NO;
	[self.navigationController setToolbarHidden:NO animated:YES];
	[self configureToolbarItems];
}
- (void) viewWillDisappear:(BOOL)animated {
	[self.player stop];
    // remove tab bar of previous window
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"customized Tab Bar");
}


@end
