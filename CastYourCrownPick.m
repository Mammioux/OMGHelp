//
//  CastYourCrowPick.m
//  iDialJesus
//
//  Created by Teresa Rios-Van Dusen on 5/4/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "CastYourCrownPick.h"


@implementation CastYourCrownPick


/*
 // The designated initializer.  Override if you create the controller programmatically
 //and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"charities" ofType:@"plist"];
    //self.charityList = [NSArray arrayWithContentsOfFile:dataPath];
    // disable left button
    [self.navigationItem setHidesBackButton: YES animated:YES];
    //self.label.text = [[self.charityList objectAtIndex:0] objectForKey:@"name"];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

/*
 - (UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component
 {
 return [charityList objectAtIndex:row];
 }
 
 -(UIView *) viewForComponent:(NSInteger)component
 {
 return @" ";
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"donated"];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)donate:(id)sender
{

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //[defaults setBool:NO forKey:@"donated"];        
        //NSString *urlStr = [[self.charityList objectAtIndex: self.charityIndex] objectForKey:@"url"];
        //NSURL * charityURL = [[NSURL alloc] initWithString: urlStr];
        //NSURLRequest *charityRequest = [NSURLRequest requestWithURL: charityURL];
        //[charityURL release];
        //[NSURLConnection sendSynchronousRequest:charityRequest returningResponse:nil error:nil];    
        [defaults setBool:YES forKey:@"donated"];
        //dismiss view
        [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIResponder

//Override this method in the controller class.
// disable cut/copy/paste menu
//NOTE: highlight and magnifing class still work
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
	if ( [UIMenuController sharedMenuController] )
	{
		[UIMenuController sharedMenuController].menuVisible = NO;
	}
	return NO;
}

@end
