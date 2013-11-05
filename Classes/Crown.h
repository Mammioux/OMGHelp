//
//  Crown.h
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/28/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Crown : NSObject
{

	int jewelIndex;
	//int jewelCount;
	NSArray *jewelery; //private array of jewel dictionaries
}

@property (nonatomic, retain) NSArray *jewelery;

//constructors
- (id)init;
- (id)initWithJewels:(int)index;

//increment jewelIndex
- (int)incrementIndex;

//get jewel index
- (int)jewelIndex;

//set jewel index
- (void)setJewelIndex:(int)index;

//get jewel count
- (int)jewelCount;

//get jewel
- (NSDictionary *)jewel;

//get jewel name
- (NSString *)jewelName;

//get color
- (NSString *)jewelColor;

//get jewel description
- (NSString *)jewelDescription;

@end
