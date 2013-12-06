//
//  QuestionViewController.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "QuestionViewController.h"
//#import	"AnswerViewController.h"
#import	"AnswerTableViewController.h"


@implementation QuestionViewController
@synthesize topic, questions;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor clearColor];
	self.tableView.separatorColor = [UIColor clearColor];
	self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"JesusRevBW.png"]];
    
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
    return( [questions count] * 2);
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    if(indexPath.row % 2 == 0){
        // Configure the even cell...
        NSDictionary *dataItem = [questions objectAtIndex: (indexPath.row / 2) ];
        cell.textLabel.text = [dataItem objectForKey:@"question"];
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiK-Medium" size:14];
        //cell.textLabel.adjustsFontSizeToFitWidth = YES; 
        cell.textLabel.numberOfLines = 7;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.detailTextLabel.text = @"sub-title";
        return cell;
    }else {
        // Configure the odd cell...
        cell.textLabel.text = @"";
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiK-Medium" size:14];
        //cell.textLabel.adjustsFontSizeToFitWidth = YES; 
        cell.textLabel.numberOfLines = 7;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        //cell.detailTextLabel.text = @"sub-title";
        return cell;
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    if(indexPath.row % 2 ==0){
        self.hidesBottomBarWhenPushed = NO;
        AnswerTableViewController *answerTableViewController = [[AnswerTableViewController alloc] initWithNibName:@"AnswerTableViewController" bundle:nil];
        
        //Get dictionary at selected row, than get all the data assocciated with that particular question
        NSDictionary *dataItem = [questions objectAtIndex:(indexPath.row / 2)];
        //It will call the all answering data of the one selected question
        answerTableViewController.answer = dataItem;
        answerTableViewController.index = (indexPath.row / 2);
        answerTableViewController.topic = topic;
        answerTableViewController.navigationItem.prompt = [dataItem objectForKey:@"question"];
        // Pass the selected object to the answerViewController.
        [self.navigationController pushViewController:answerTableViewController animated:YES];
        [answerTableViewController release];
    }//if row is even
    
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
    [questions release];
    [topic release];
    [super dealloc];
}


@end

