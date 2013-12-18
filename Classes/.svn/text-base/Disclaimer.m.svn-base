//
//  Disclaimer.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 4/11/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Disclaimer.h"
//#import "RootViewController.h"

@implementation Disclaimer
@synthesize disc;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        //NSLog(@"Showing Modal view");
        self.disc.font = [UIFont fontWithName:@"STHeitiK-Medium" size:12];

        //self.view.backgroundColor = [UIColor clearColor];
        //self.tableView.separatorColor = [UIColor clearColor];
        // self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"JesusRevBW.png"]];
        //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"JesusRevBW.png"]];
        
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger timeWait = [defaults integerForKey:@"time_preference"];//check if time_preference was initialized
    
    if (timeWait == 0) {
        	[defaults setInteger:86400 forKey:@"time_preference"];
    }
    
	//self.navigationItem.hidesBackButton = YES;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;   
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

- (void)viewDidUnload {
    [super viewDidUnload];
    
}


- (void)dealloc {
    [super dealloc];
}

-(void) viewWillDisappear:(BOOL)animated
{
	//NSLog(@"Disclaimer View going away");
}

- (IBAction)agree:(id)sender{
    //NSLog(@"agree on Disclaimer");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"agreed"];
	[defaults setBool:YES forKey:@"agreed_preference"];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (IBAction)info:(id)sender{
    UIAlertView *alert;
    //NSLog(@"easter egg");
    NSString *message = @"Luiz Carlos Rios-Abreu and Teresa Van Dusen - www.nonstandardsolutions.com";
    alert = [[UIAlertView alloc] initWithTitle:@"Developed by " 
                                       message:message 
                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];    
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

@end
