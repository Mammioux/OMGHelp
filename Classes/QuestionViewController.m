//
//  QuestionViewController.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "QuestionViewController.h"
#import	"AnswerViewController.h"
#import "IDialJesusAppDelegate.h"


@implementation QuestionViewController
@synthesize topic, questions, font;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = self.topic;//Style change: the controller loads its own title.
	self.view.backgroundColor = [UIColor clearColor];
	self.tableView.separatorColor = [UIColor clearColor];
    self.font = [UIFont fontWithName:@"STHeitiK-Medium" size:14]; // define font for all questions
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"JesusRevBW.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
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
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return([questions count]);
}


// Customize the appearance of table view cells.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Return the height of a question view row
    //return 80.0;
    return 6 * self.font.lineHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"questionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure cell
    NSDictionary *dataItem = [questions objectAtIndex: (indexPath.row)];
    cell.textLabel.text = [dataItem objectForKey:@"question"];
    cell.textLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.textLabel.font = [UIFont fontWithName:@"STHeitiK-Medium" size:14];
    cell.textLabel.font = self.font;
    //cell.textLabel.adjustsFontSizeToFitWidth = YES; 
    cell.textLabel.numberOfLines = 7;
    cell.backgroundColor = [UIColor clearColor];
    //cell.textLabel.textAlignment = UITextAlignmentCenter;
    //cell.detailTextLabel.text = @"sub-title";
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
#pragma mark Table view delegate

//  The method below is the old way to transition from one view controller to another, before the
//storyborad. It also uses the old cell indexing, in which only even cells have relevant content and
//odd cells are separators. Maybe it should just be completely deleted for it is beyond deprecated 
//it is incompatible with the code now.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
        self.hidesBottomBarWhenPushed = NO;
        AnswerViewController *answerViewController = [[AnswerViewController alloc] initWithNibName:@"AnswerTableViewController" bundle:nil];
        
        //Get dictionary at selected row, than get all the data assocciated with that particular question
        NSDictionary *dataItem = [questions objectAtIndex:(indexPath.row)];
        //It will call the all answering data of the one selected question
        answerViewController.answer = dataItem;
        answerViewController.index = (indexPath.row);
        answerViewController.topic = topic;
        answerViewController.navigationItem.prompt = [dataItem objectForKey:@"question"];
        // Pass the selected object to the answerViewController.
    if (isIPAD) {
        NSLog(@"Load  answer on detail panel of split view");
        IDialJesusAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.detailvc = answerViewController;
    } else {
        [self.navigationController pushViewController:answerViewController animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // check for our segue identifier
    if ([segue.identifier isEqualToString:@"pushAnswerView"])
    {
        // sender is the table view cell
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
        NSDictionary *dataItem = [questions objectAtIndex:(indexPath.row)];            
        
        // prepare answer view controller with new content
        AnswerViewController *answerViewController = segue.destinationViewController;
            
        // pass answer data to answer view controller
        answerViewController.answer = dataItem;
        answerViewController.index = (indexPath.row);
        answerViewController.topic = self.topic;
        self.hidesBottomBarWhenPushed = NO;
        [self.navigationController setToolbarHidden:NO animated:YES];
        return;
    }//if seque == @"pushAnswerView"
    if ([segue.identifier isEqualToString:@"showAnswerView"])
    {
        // sender is the table view cell
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
        NSDictionary *dataItem = [questions objectAtIndex:(indexPath.row)];
        
        // prepare answer view controller with new content
        AnswerViewController *answerViewController = segue.destinationViewController;
        
        // pass answer data to answer view controller
        answerViewController.answer = dataItem;
        answerViewController.index = (indexPath.row);
        answerViewController.topic = self.topic;
        answerViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        answerViewController.navigationItem.leftItemsSupplementBackButton = YES;
    }//if seque == @"showAnswerView"

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

@end

