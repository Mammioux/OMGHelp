//
//  CastYourCrowPick.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 5/4/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "CastYourCrownPick.h"


@implementation CastYourCrownPick

@synthesize pickerView;
@synthesize charityList;
@synthesize charityIndex;

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
	NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"charities" ofType:@"plist"];
    self.charityList = [NSArray arrayWithContentsOfFile:dataPath];
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


- (void)dealloc {
    [charityList release];
    [super dealloc];
}

#pragma mark - 
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row 
	                                           inComponent:(NSInteger)component
{    
	//NSLog(@"call webpage for charity %@", [[self.charityList objectAtIndex:row] objectForKey:@"name"]);
    //NSLog(@"call webpage for charity %@", [[self.charityList objectAtIndex:row] objectForKey:@"url"]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Charity Selected" 
                                       message:[[self.charityList objectAtIndex:row] objectForKey:@"name"] 
                                      delegate:self
                             cancelButtonTitle:@"cancel"
                             otherButtonTitles:@"confirm", nil];
    self.charityIndex = row;
    [alert show];
    [alert release];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
			                                        forComponent:(NSInteger)component
{
	if (row < 0 || row >= [self.charityList count]) 
	{
		NSLog(@"row %d is out of bounds array size is %d",
			  row, [self.charityList count]);
		return @" ";
	}
	return [[self.charityList objectAtIndex:row] objectForKey:@"name"];
}

/*
 - (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return(20.0);
}

 - (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row 
                                                  forComponent:(NSInteger)component
                                                  reusingView:(UIView *)view
{
	// Create a new view that contains a label offset from the right.
    return [charityList objectAtIndex:row];	
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return(20.0);
}
*/

#pragma mark - 
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.charityList count];
}

#pragma mark - 
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	//NSLog(@"button pressed index %d", buttonIndex);
    if(buttonIndex == 1)
    {
        NSString *urlStr = [[self.charityList objectAtIndex: self.charityIndex] objectForKey:@"url"];
        NSURL * charityURL = [[NSURL alloc] initWithString: urlStr];
        NSURLRequest *charityRequest = [NSURLRequest requestWithURL: charityURL];
        [charityURL release];
        [NSURLConnection sendSynchronousRequest:charityRequest returningResponse:nil error:nil];
    }//if user pressed <confirm>
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