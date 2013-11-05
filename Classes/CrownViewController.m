//
//  CrownViewController.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 4/23/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "CrownViewController.h"

@implementation CrownViewController

@synthesize player;
@synthesize muted;
@synthesize jewelsArray;
@synthesize songsArray;
@synthesize jewelDictArray;
@synthesize ruby;
@synthesize topaz;
@synthesize emerald;
@synthesize turquoise;
@synthesize sapphire;
@synthesize amber;
@synthesize agate;
@synthesize amethyst;
@synthesize beryl;
@synthesize onyx;
@synthesize jasper;
@synthesize chalcedony;
@synthesize sardonyx;
@synthesize chrysoprase;
@synthesize aquamarine;
@synthesize garnet;
@synthesize peridot;
@synthesize opal;
@synthesize yellowsapphire;
@synthesize pearl;
@synthesize whitesapphire;
@synthesize redcoral;
@synthesize diamond;
@synthesize crownImage, colorCrownImage;

#pragma mark -
#pragma mark View lifecycle

// The designated initializer.  Override if you create the controller programmatically
//and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        NSLog(@"Crown View Initializing with nib");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSInteger count = [defaults integerForKey:@"count"];//internal persistent jewel count
        
        //info and sound data paths
        NSString *jewelPath = [[NSBundle mainBundle] pathForResource:@"jewels" ofType:@"plist"];
        NSString *songPath  = [[NSBundle mainBundle] pathForResource:@"songs"  ofType:@"plist"];
		
        //info and sound property arrays. Info array is mutable
        self.jewelDictArray = [NSArray arrayWithContentsOfFile:jewelPath];
        self.songsArray = [NSArray arrayWithContentsOfFile:songPath];

        //custom button to back all the way to root (or topic) view 
        UIBarButtonItem *customBack = [[UIBarButtonItem alloc] initWithTitle: @"iDialJesus" 
                                                                       style: UIBarButtonItemStyleDone
                                                                      target: self 
                                                                      action: @selector(left:)];
		//self.navigationItem.backBarButtonItem = customBack;//
	    self.navigationItem.leftBarButtonItem = customBack;//we must use left instead of back
        [customBack release];
        
        //select crown image based on jewel count
        if (count >= ([self.jewelDictArray count]-1)) {
			colorCrownImage.hidden = NO; //all painted crown
			crownImage.hidden = YES;//crown with white frame
        }//if count is greater than max jewel index
    }//if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    return self;
}//(id)initWithNibName

- (void) enableJewels: (NSArray *) jewelery count: (NSInteger) count
{
    NSInteger c = (count < [jewelery count]) ? count : [jewelery count];

    //for (int i=0; i<[jewelery count] && i < count; i++) {
    for (int i=0; i < c; i++) {
        UIButton *j = [jewelery objectAtIndex:i];
        j.enabled = YES;        
    }
    if (count >= 23) {
        //NSString *coloredCrownPath = [[NSBundle mainBundle] pathForResource:@"crownEmptyColor" ofType:@"png"];
        //[crownImage.image initWithContentsOfFile:coloredCrownPath];
		colorCrownImage.hidden = NO;
		crownImage.hidden = YES;
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIAlertView *alert;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger count = [defaults integerForKey:@"count"];
	//NSString *jewelPath = [[NSBundle mainBundle] pathForResource:@"jewels" ofType:@"plist"];
    //self.jewelDictArray = [NSArray arrayWithContentsOfFile:jewelPath];
    
	//Get today's date nad minimum wait time
    NSDate *now = [NSDate date];
    NSTimeInterval minWaitTime = [defaults integerForKey:@"time_preference"];
    NSLog(@"and %ld seconds interval between adding jewels", minWaitTime);
    
    if (count < [self.jewelDictArray count]) {
        NSDictionary *jewel = [self.jewelDictArray objectAtIndex:count];
        if (count == 0) {
            [defaults setObject:now forKey:@"timestamp"];
            NSString *message = [NSString stringWithFormat: @"Your crown now has the jewel %@ added. Meaning: %@", 
                                                          [jewel objectForKey:@"stone"], 
                                                          [jewel objectForKey:@"description"]];
            alert = [[UIAlertView alloc] initWithTitle:@"Your Crown" 
                                                       message:message 
                                                       delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles: nil];
            count++;//first jewel made vailable
        }//if it is the first time
        else {
            //get last time stamp
            //NSDate *lastTime = [defaults objectForKey:@"timestamp"];
            NSDate *nextTime =[[defaults objectForKey:@"timestamp"] addTimeInterval: minWaitTime];
            
            if(  ([now compare:nextTime] == NSOrderedSame)
               ||([now compare:nextTime] == NSOrderedDescending) ){
                [defaults setObject:now forKey:@"timestamp"];
                NSString *message = [NSString stringWithFormat: @"Your crown now has the jewel %@ added. Meaning: %@", 
                                     [jewel objectForKey:@"stone"], 
                                     [jewel objectForKey:@"description"]];
                alert = [[UIAlertView alloc] initWithTitle:@"Your Crown" 
                                                   message:message 
                                                  delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
                //[nextTime release];
                count++;//another jewel made vailable
            }//if enough time has passed
            else{
                NSString *message = [NSString stringWithFormat: @" \" There is a time for everything, and a season for every activity under heaven.\" Ecclesiastes 3:1 \n\n Only one jewel can be earned per day. Please try again tomorrow."];
                alert = [[UIAlertView alloc] initWithTitle:@"Your Crown" 
                                                   message:message 
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles: nil];
            }//if NOT enough time has passed
        }//if count in [1 to last array index]
    }//if count is less than number of elements in array
    else{
        NSString *message = @"For what is our Hope, our Joy, or the Crown in which we will glory in the presence of our Lord Jesus when he comes? Is it not you? Indeed you are our glory and joy! - Thessalonians 2:19-20";
        alert = [[UIAlertView alloc] initWithTitle:@"Your Crown is Complete. Congratulations!" 
                                           message:message
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }//if we have all jewels made vailable already
    
	self.muted = [defaults boolForKey:@"muted"];
    srandom(time(NULL));
    int index = (random() % [self.songsArray count]);
    NSDictionary *song = [self.songsArray objectAtIndex:index];
	NSString *filename = [[NSString alloc] initWithFormat:[song objectForKey:@"name"]];
	//NSLog(@"filename = %@", filename);
    
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: filename
                                                        ofType:[song objectForKey:@"ext"]];
    [filename release];
    //NSLog(@"soundFilePath = %@", soundFilePath);
	if(soundFilePath != nil) {
		NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
		AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
																		  error: nil];
		[fileURL release];
        
        newPlayer.delegate = self;
		
		self.player = newPlayer;
		[newPlayer release];
		
        //[self.player prepareToPlay];
		[self.player setVolume: 1.0];
		if(!muted) [self.player play];
	}//if  soundFilePath is not nil
    
    self.jewelsArray = [NSArray arrayWithObjects:ruby, topaz, emerald, turquoise, sapphire, amber, agate,
                        amethyst, beryl, onyx, jasper, chalcedony, sardonyx, chrysoprase, aquamarine,
                        garnet, peridot, opal, yellowsapphire, pearl, whitesapphire, redcoral, diamond, nil]; 
    [self enableJewels: self.jewelsArray count: count];
    
    //count has been incremented in the 2 situations when a jewel is made vailable
    [defaults setInteger:count forKey:@"count"];
	[defaults setInteger:count forKey:@"count_preference"];
    [alert show];
    [alert release];
    
} //- (void)viewDidLoad

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Crown View Controller will appear");   
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger count = [defaults integerForKey:@"count"];
	
	[self enableJewels: jewelsArray count: count];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	[self.player stop];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [jewelsArray release];
}

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	NSUInteger tapCount = [touch tapCount];
	
	switch (tapCount)
    {
		case 1:
			[self performSelector:@selector(singleTap) withObject:nil afterDelay:.4];
            break;
            
		case 2:
            [self performSelector:@selector(doubleTap) withObject:nil afterDelay:.4];
			break;
            
		case 3:
            [self performSelector:@selector(tripleTap) withObject:nil afterDelay:.4];
			break;
            
		case 4:
            [self performSelector:@selector(quapleTap) withObject:nil afterDelay:.4];
			break;
            
		default:
			break;
	}//multi-way branching on number of taps
}//touchesBegan

#pragma mark -
#pragma mark API

- (void)singleTap
{    
	NSLog(@"single tap");
}

- (void)doubleTap
{    
	NSLog(@"double tap");
}


- (void)tripleTap
{    
	NSLog(@"triple tap");
}

- (void)quapleTap
{    
	NSLog(@"quadruple tap");
}

- (IBAction)left:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)info:(id)sender
{
    UIAlertView *alert;
    
    //UIButton *stone = sender;
    NSInteger index = [jewelsArray indexOfObject:sender];
	NSString *jewelPath = [[NSBundle mainBundle] pathForResource:@"jewels" ofType:@"plist"];
    NSArray *jewelery = [NSArray arrayWithContentsOfFile:jewelPath];
    NSDictionary *d = [jewelery objectAtIndex:index];
    
    NSString *message = [NSString stringWithFormat: @"The jewel %@ means: %@", 
                         [d objectForKey:@"stone"], 
                         [d objectForKey:@"description"]];   
    
    alert = [[UIAlertView alloc] initWithTitle:@"Your Crown" 
                                       message:message 
                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    [alert release];
    
}

- (void)dealloc {
    [player release];
    [jewelsArray release];
    [songsArray release];
    [ruby release];
    [topaz release];
    [emerald release];
    [turquoise release];
    [sapphire release];
    [amber release];
    [agate release];
    [amethyst release];
    [beryl release];
    [onyx release];
    [jasper release];
    [chalcedony release];
    [sardonyx release];
    [chrysoprase release];
    [aquamarine release];
    [garnet release]; 
    [peridot release];
    [opal release];
    [yellowsapphire release];
    [pearl release];
    [whitesapphire release];
    [redcoral release];
    [diamond release];    
    [crownImage release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark AVAudioPlayer delegate

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. 
This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    srandom(time(NULL));
    int index = (random() % [self.songsArray count]);
    NSDictionary *song = [self.songsArray objectAtIndex:index];
	NSString *filename = [[NSString alloc] initWithFormat:[song objectForKey:@"name"]];
    NSString *file_ext = [[NSString alloc] initWithFormat:[song objectForKey:@"ext"]];
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: filename ofType:file_ext];
    NSLog(@"audioPlayerDidFinishPlaying: filename = %@.%@", filename, file_ext);
    [filename release];
    [file_ext release];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    [self.player initWithContentsOfURL: fileURL error: nil];
    [fileURL release];
    //[self.player prepareToPlay];
    self.player.delegate = self;
    [self.player setVolume: 1.0];
    [self.player play];
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    
}

/* audioPlayerBeginInterruption: is called when the audio session has been interrupted while the player was playing. 
The player will have been paused. */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    
}
/* audioPlayerEndInterruption: is called when the audio session interruption has ended and this player had been interrupted while playing.
 The player can be restarted at this point. */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player {
    
}

@end
