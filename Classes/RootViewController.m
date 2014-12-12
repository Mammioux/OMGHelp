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
#import "IDialJesusAppDelegate.h"

//hopefully only one will stay
#import "CastYourCrownPick.h"

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

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
	//basic configuration
	self.hidesBottomBarWhenPushed = YES;
    [self.navigationController setToolbarHidden:!isIPAD animated:YES];
	self.view.backgroundColor = [UIColor clearColor];
	self.tableView.separatorColor = [UIColor clearColor];
    
	// read BETA test settings
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//NSLog(@"User should agree next time? %@",[defaults boolForKey:@"agreed_preference"]?@"YES":@"NO");
	//NSLog(@"with %d jewels",[defaults integerForKey:@"count_preference"]);
	//NSLog(@"and %ld seconds interval between adding jewels",[defaults integerForKey:@"time_preference"]);

	//initialize internal persistent jewel count in BETA test
	[defaults setInteger:[defaults integerForKey:@"count_preference"] forKey:@"count"];
	
    // Load the data.
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"JesusRevBW.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];

    NSString *dataPath     = [[NSBundle mainBundle] pathForResource:@"topics"   ofType:@"plist"];
	//NSString *jewelPath    = [[NSBundle mainBundle] pathForResource:@"jewels"   ofType:@"plist"];
	
	// sort by topic
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"topic" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    self.data = [[NSArray arrayWithContentsOfFile:dataPath] sortedArrayUsingDescriptors:sortDescriptors];
	
	//NSInteger count = [defaults integerForKey:@"count"];
	BOOL agreed = [defaults	boolForKey:@"agreed_preference"];
	if (!agreed)
	{
	    [defaults setBool:YES forKey:@"agreed_preference"];
	}else {
		agreed = [defaults boolForKey:@"agreed"];
	}

    //self.jewelery = [NSArray arrayWithContentsOfFile:jewelPath];
	
	if (!agreed){

		// Pass the selected object to the new view controller.
		Disclaimer *disclaimer = [[Disclaimer alloc] initWithNibName:@"Disclaimer" bundle:nil];
 		[self.navigationController presentViewController:disclaimer animated:YES completion:nil];
	}
/*    
    BOOL donated = [defaults boolForKey:@"donated"];
    
    if (!donated) {
		CastYourCrownPick *cast = [[CastYourCrownPick alloc] initWithNibName:@"CastYourCrownPick" bundle:nil];
		[self.navigationController pushViewController:cast animated:YES];
		[cast release];
    }
    
*/	//[defaults setObject:jewelery forKey: @"jewelery"];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


//- (void)done:(id)sender {
//	About *about = [[About alloc] initWithNibName:@"About" bundle:nil];
//	[self.navigationController pushViewController:about animated:YES];
//}

/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if ([alertView.title compare:@"Closing Thy will Jesus"] == NSOrderedSame) {
		[[UIApplication sharedApplication] terminateWithSuccess];	
	}
}

*/
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
    
    static NSString *CellIdentifier = @"topicCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	// Configure the cell.
	
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.backgroundColor = [UIColor clearColor];
	//cell.textLabel.textAlignment = UITextAlignmentCenter;
    
    NSDictionary *dataItem = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataItem objectForKey:@"topic"];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
       	QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
        // ...
        NSDictionary *dataItem = [data objectAtIndex:indexPath.row];
        NSArray *questions = [dataItem objectForKey:@"questions"];
        questionViewController.questions = questions;
        questionViewController.topic = [dataItem objectForKey:@"topic"];
        questionViewController.hidesBottomBarWhenPushed = YES;
        questionViewController.navigationItem.title = [dataItem objectForKey:@"topic"];
        
        IDialJesusAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        questionViewController.delegate = appDelegate.detailvc ;
        
        self.hidesBottomBarWhenPushed = NO;
        [self.navigationController setToolbarHidden:NO animated:YES];
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:questionViewController animated:YES];
        //It will call the list of questions for the selected topic 
    }
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // check for our segue identifier
    if ([segue.identifier isEqualToString:@"pushQuestionView"])
    {
        // sender is the table view cell
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
        NSDictionary *dataItem = [data objectAtIndex:indexPath.row];
        NSArray *questions = [dataItem objectForKey:@"questions"];
        
        // prepare question view controller with new content
        QuestionViewController *questionViewController = isIPAD? (QuestionViewController *)[[segue destinationViewController] topViewController]:(QuestionViewController *)segue.destinationViewController;
        
        // pass topic data to question view controller
        questionViewController.questions = questions;
        questionViewController.topic = [dataItem objectForKey:@"topic"];
        questionViewController.hidesBottomBarWhenPushed = YES;
        //questionViewController.navigationItem.title = [dataItem objectForKey:@"topic"];
        self.hidesBottomBarWhenPushed = NO;
        [self.navigationController setToolbarHidden:NO animated:YES];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            questionViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        } else {
            //questionViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        }
        questionViewController.navigationItem.leftItemsSupplementBackButton = YES;
    }//if seque == @"pushQuestionView"
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
	// read settings
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:[defaults integerForKey:@"count"] forKey:@"count_prefrence"];

}

@end

