//
//  RootViewController.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/23/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "RootViewController.h"
#import	"QuestionViewController.h"
#import "Disclaimer.h"
#import "About.h"

@implementation RootViewController

@synthesize data;
@synthesize jewelery;

#pragma mark -
#pragma mark View lifecycle
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 self.hidesBottomBarWhenPushed = YES;
 [self.navigationController setToolbarHidden:YES animated:YES];	
 }
 
 return self;
 }
 */

- (void)viewDidLoad {
    [super viewDidLoad];
	// Load the data.
	
	self.hidesBottomBarWhenPushed = YES;
	[self.navigationController setToolbarHidden:YES animated:YES];
	self.view.backgroundColor = [UIColor clearColor];
	self.tableView.separatorColor = [UIColor clearColor];
	self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"JesusRevBW.png"]];
	self.navigationItem.title = @"Tell Me Jesus";
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"topics" ofType:@"plist"];
	// sort by topic
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"topic" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
    self.data = [[NSArray arrayWithContentsOfFile:dataPath] sortedArrayUsingDescriptors:sortDescriptors];
	[sortDescriptor release];
    [sortDescriptors release];
	
	UIBarButtonItem *done = self.navigationItem.rightBarButtonItem;
	[done initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action: @selector(done:)];  
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//NSInteger count = [defaults integerForKey:@"count"];
	BOOL agreed = [defaults	boolForKey:@"agreed"];
	
	NSString *jewelPath = [[NSBundle mainBundle] pathForResource:@"jewels" ofType:@"plist"];
    self.jewelery = [NSArray arrayWithContentsOfFile:jewelPath];
	[self dumpJewels];
	
	if (!agreed){
		NSLog(@"first time use");
		
		//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Guide Me Jesus" message:@"First Time use"
		//											   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		//[alert show];	
		//[alert release];
		// Pass the selected object to the new view controller.
		Disclaimer *disclaimer = [[Disclaimer alloc] initWithNibName:@"Disclaimer" bundle:nil];
 		[self.navigationController presentViewController:disclaimer animated:YES completion:NULL];
		[disclaimer release];
	} else {
		NSLog(@"continuing using the application");
	}
	[defaults setObject:jewelery forKey: @"jewelery"];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)done:(id)sender {
	About *about = [[About alloc] initWithNibName:@"About" bundle:nil];
	[self.navigationController pushViewController:about animated:YES];
	[about release];	
	
	/*
	 UIAlertView *alert;
	 
	 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	 NSInteger count = [defaults integerForKey:@"count"];
	 [self dumpJewels];
	 if (count== 0 ){
	 NSLog(@"first time use");
	 alert = [[UIAlertView alloc] initWithTitle:@"Closing Guide Me Jesus" message:@"Showing the View with Crown and Donation radio buttons"
	 delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	 }
	 
	 NSDictionary *d = [jewelery objectAtIndex:count];
	 NSString *message = [NSString stringWithFormat: @"Your crown now has the jewell %@ added. Meaning: %@", 
	 [d objectForKey:@"stone"], 
	 [d objectForKey:@"description"]];
	 alert = [[UIAlertView alloc] initWithTitle:@"Closing Guide Me Jesus" 
	 message:message 
	 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	 [defaults setInteger:++count forKey:@"count"];
	 [alert show];
	 [alert release];
	 */
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if ([alertView.title compare:@"Closing Guide Me Jesus"] == NSOrderedSame) {
       //[NSThread exit];
       exit(0);
	}
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.hidesBottomBarWhenPushed = YES;
	[self.navigationController setToolbarHidden:YES animated:YES];
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */

- (void)viewWillDisappear:(BOOL)animated {
	NSLog(@"Root view will disappear");
	
	[self dumpJewels];
	/*	[super viewWillDisappear:animated];
	 UIAlertView *alert;
	 
	 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	 
	 if ([defaults objectForKey:@"firstTime"]==nil ){
	 NSLog(@"first time use");
	 alert = [[UIAlertView alloc] initWithTitle:@"OMGHelp" message:@"Leaving the application after first time use"
	 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	 [defaults setBool:NO forKey:@"firstTime"];
	 }
	 else {
	 alert = [[UIAlertView alloc] initWithTitle:@"OMGHelp" message:@"Leaving the application already used"
	 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	 
	 }
	 
	 [alert show];
	 [alert release];
	 */
}

/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [data count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.backgroundColor = [UIColor clearColor];
	cell.textLabel.textAlignment = NSTextAlignmentCenter; 
    
    NSDictionary *dataItem = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataItem objectForKey:@"topic"];
	
    return cell;
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
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self dumpJewels];
    
	
	QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
	// ...
	NSDictionary *dataItem = [data objectAtIndex:indexPath.row];
    NSArray *questions = [dataItem objectForKey:@"questions"];
	questionViewController.questions = questions;
	questionViewController.topic = [dataItem objectForKey:@"topic"];
    questionViewController.hidesBottomBarWhenPushed = YES;
    questionViewController.navigationItem.title = [dataItem objectForKey:@"topic"];
	self.hidesBottomBarWhenPushed = NO;
	[self.navigationController setToolbarHidden:NO animated:YES];
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:questionViewController animated:YES];
	[questionViewController release];
	//It will call the list of questions for the selected topic
	
}


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

-(void)dumpJewels
{
	/*
	 NSLog(@"dump jewels");
	 for (int i=0; i < [jewelery count]; ++i) {
	 NSDictionary *d= [jewelery objectAtIndex:i];
	 NSLog(@"Index: %d, Stone:%@",i,[d objectForKey:@"stone"]);
	 }
	 */
}

@end

