//
//  About.h
//  iDialJesus
//
//  Created by Teresa Rios-Van Dusen on 4/13/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface About : UIViewController {
	UIWebView	*aboutPage;

}

//@property (nonatomic,retain) IBOutlet UIWebView *aboutPage;
@property (weak, nonatomic) IBOutlet UIWebView *aboutHtml;

@end
