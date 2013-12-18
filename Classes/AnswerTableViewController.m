//
//  AnswerTableViewController.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 4/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AnswerTableViewController.h"


@implementation AnswerTableViewController
@synthesize index,player;
@synthesize answer;
@synthesize scrollTextView;
@synthesize muted;
@synthesize doneButton;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    // Custom initialization
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController setToolbarHidden:NO animated:YES];
    [self configureToolbarItems];
    
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	self.muted = [defaults boolForKey:@"muted"];
	
	UIBarButtonItem *mute = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:muted?UIBarButtonSystemItemPlay:UIBarButtonSystemItemPause 
																		  target:self action: @selector(toggleSound:)];  
    
    [self.navigationItem setRightBarButtonItem:mute];
	[mute release];
	
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
	if(!muted) [self.player play];	
    
    self.scrollTextView.font = [UIFont fontWithName:@"STHeitiK-Medium" size:12];
    
    self.doneButton.enabled = NO;
    
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
                                             @"Learn More",
                                             nil]];
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.frame = CGRectMake(0, 0, 300, 30.0);
	//segmentedControl.segmentedControlStyle=UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 0;
	//segmentedControl.momentary = YES;
	
	//UIColor *defaultTintColor = [segmentedControl.tintColor retain];	// keep track of this for later
    
	UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    [segmentedControl release];
  	// Set our toolbar items	
	[self setToolbarItems:[NSArray arrayWithObjects:						 
						   flexibleSpaceButtonItem,						 
						   segmentBarItem,	
						   flexibleSpaceButtonItem,	
						   nil] animated: YES];	
    [self showQuote];
	
	[segmentBarItem release];
	[flexibleSpaceButtonItem release];	
}


- (IBAction)segmentAction:(id)sender
{
	// The segmented control was clicked, handle it here 
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	NSLog(@"Segment clicked: %d", segmentedControl.selectedSegmentIndex);
    self.navigationItem.title = [segmentedControl titleForSegmentAtIndex:segmentedControl.selectedSegmentIndex];
    switch (segmentedControl.selectedSegmentIndex) {
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
    self.doneButton.enabled = NO;
    [self.player stop];
	[self.player prepareToPlay];
    [self.player setVolume: 1.0];
    
    if (muted) {
        [self.player pause];
    } else {
        [self.player play];
    }
    
}
- (void) showExplanation
{
	scrollTextView.text = [answer objectForKey:@"explanation"];
    self.doneButton.enabled = NO;
}
- (void) showGetReal
{
	scrollTextView.text = [answer objectForKey:@"examples"];
    self.doneButton.enabled = YES;
}
- (void) showLinks
{
	scrollTextView.text = [[answer objectForKey:@"links"] description];
    self.doneButton.enabled = NO;
}
- (IBAction)done:(id)sender {
    UIAlertView *alert;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger count = [defaults integerForKey:@"count"];
    if (count== 0 ){
        NSLog(@"first time use");
        alert = [[UIAlertView alloc] initWithTitle:@"Closing Tell Me Jesus" message:@"Showing the View with Crown and Donation radio buttons"
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    NSString *jewelPath = [[NSBundle mainBundle] pathForResource:@"jewels" ofType:@"plist"];
    NSArray *jewelery = [NSArray arrayWithContentsOfFile:jewelPath];
    
    
    NSDictionary *d = [jewelery objectAtIndex:count];
    NSString *message = [NSString stringWithFormat: @"Your crown now has the jewel %@ added. Meaning: %@", 
                         [d objectForKey:@"stone"], 
                         [d objectForKey:@"description"]];
    alert = [[UIAlertView alloc] initWithTitle:@"Closing Tell Me Jesus" 
                                       message:message 
                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [defaults setInteger:++count forKey:@"count"];
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if ([alertView.title compare:@"Closing Tell Me Jesus"] == NSOrderedSame) {
		//[[UIApplication sharedApplication] terminateWithSuccess];	
	}
}



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

/*
 #pragma mark -
 #pragma mark Table view data source
 
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 // Return the number of sections.
 return 4;
 }
 
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 // Return the number of rows in the section.
 return 1;
 }
 
 // customize the section headers
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
 if (section == 2) {
 return 20.0;
 }
 else {
 return	0.0;
 }
 
 }
 
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 if (section == 2) {
 UILabel *sectionHDR = [[UILabel alloc] autorelease];
 sectionHDR.text = @"Get Real";
 return sectionHDR;
 }
 else {
 return nil;
 }
 
 }
 
 // Customize the appearance of table view cells.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 static NSString *CellIdentifier = @"Cell";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
 }
 
 // Configure the cell...
 cell.textLabel.numberOfLines = 0;
 cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
 cell.textLabel.font = [UIFont fontWithName:@"STHeitiK-Medium" size:12];
 switch (indexPath.section) {
 case 0:
 cell.textLabel.text = [answer objectForKey:@"bible quote"];
 break;
 case 1:
 cell.textLabel.text = [answer objectForKey:@"explanation"];
 break;
 case 2:
 
 cell.textLabel.text = [answer objectForKey:@"examples"];
 
 break;			
 case 3:
 cell.textLabel.text = [[answer objectForKey:@"links"] description];
 break;
 default:
 break;
 }
 return cell;
 }
 */

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
	UIBarButtonItem *mute = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:muted?UIBarButtonSystemItemPlay:UIBarButtonSystemItemPause 
                                                                          target:self action: @selector(toggleSound:)];  
	
	[self.navigationItem setRightBarButtonItem:mute animated:YES];
	[mute release];
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark -
 #pragma mark Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here. Create and push another view controller.
 
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
 // ...
 // Pass the selected object to the new view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 [detailViewController release];
 
 }
 
 */
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

