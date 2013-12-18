//
//  About.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 4/13/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "About.h"


@implementation About

@synthesize aboutPage;

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
	NSString *path = [[NSBundle mainBundle] pathForResource:@"About" ofType:@"htm"];
	NSString *resourcePath = [[NSBundle mainBundle] bundlePath];
	NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];

	NSString *htmlString = [[NSString alloc] initWithData: 
							[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
	
	// to make html content transparent to its parent view -
	// 1) set the webview's backgroundColor property to [UIColor clearColor]
	// 2) use the content in the html: <body style="background-color: transparent">
	// 3) opaque property set to NO
	//
	//aboutPage.opaque = NO;
	//aboutPage.backgroundColor = [UIColor clearColor];
	[self.aboutPage loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:resourcePath]];
	
	self.view.backgroundColor = [UIColor clearColor];
	//self.tableView.separatorColor = [UIColor clearColor];
	self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"JesusRevBW.png"]];
	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"JesusRevBW.png"]];
	
	[htmlString release];
	[resourcePath release];
	
	
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
    [aboutPage release];
	[super dealloc];
	
}


@end
