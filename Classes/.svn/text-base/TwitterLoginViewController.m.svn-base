//
//  TwitterLoginViewController.m
//  iDialJesus
//
//  Created by Teresa Rios-Van Dusen on 5/31/10.
//  Copyright 2010 iDialJesus. All rights reserved.
//

#import "TwitterLoginViewController.h"
#import "TwitterRequest.h"


@implementation TwitterLoginViewController

@synthesize tuid,tpwd;
@synthesize quote;
@synthesize t;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
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
    //manipulate quote here to make it fit in 144 characters
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction) postTweet: (id) sender {
        NSLog(@"Login to Twitter");
	t.username = tuid.text;
	t.password = tpwd.text;
    
	loadingActionSheet = [[UIActionSheet alloc] initWithTitle:@"Posting To Twitter..." delegate:nil 
											cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    NSString *tweet = [NSString stringWithFormat:@"#iDialJesus %@", quote ];
	[t statuses_update: tweet delegate:self requestSelector:@selector(status_updateCallback:)];
	[loadingActionSheet showInView:self.view];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == [self tuid]) {
        NSLog(@"Entered UID");
    } else {
        NSLog(@"Entered PWD");
    }
      [textField resignFirstResponder];
    return YES;

}

#pragma mark -
#pragma mark TwitterRequest

- (void) status_updateCallback: (NSData *) content {
	[loadingActionSheet dismissWithClickedButtonIndex:0 animated:YES];
	[loadingActionSheet release];
	NSLog(@"%@",[[NSString alloc] initWithData:content encoding:NSASCIIStringEncoding]);
    [self dismissModalViewControllerAnimated:YES];
}


@end
