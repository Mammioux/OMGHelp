//
//  CastYourCrowPick.h
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 5/4/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUrlCharity1 @"http://www.nonstandardsolutions.com/2009/07/how-is-igeneration-going-to-shop-in-5.html"
#define kUrlCharity2 @"http://www.nonstandardsolutions.com/2008/06/unusual-sources-of-inspiration.html"
#define kUrlCharity3 @"http://www.nonstandardsolutions.com/2008/05/other-day-i-listened-on-radio-interview.html"


@interface CastYourCrownPick : UIViewController <UIPickerViewDelegate,
                                                 UIPickerViewDataSource,
                                                 UIAlertViewDelegate>{
    IBOutlet UIPickerView *pickerView;
    //UILabel *label;
	NSArray *charityList;
    NSInteger charityIndex;
}

@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
//@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) NSArray *charityList;
@property (nonatomic, readwrite) NSInteger charityIndex;

//- (UIView *)viewForComponent:(NSInteger)component;
//- (void)updateLabel;

@end
