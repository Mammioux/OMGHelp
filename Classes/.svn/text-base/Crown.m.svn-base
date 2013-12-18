//
//  Crown.m
//  OMGHelp
//
//  Created by Teresa Rios-Van Dusen on 3/28/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Crown.h"

@implementation Crown

@synthesize jewelery;

//constructors
- (id)init
{
    [super init];
	
    NSString *jewelPath = [[NSBundle mainBundle] pathForResource:@"jewels" ofType:@"plist"];
    jewelery = [NSArray arrayWithContentsOfFile:jewelPath];
    jewelIndex = 0;
	//jewelCount = [jewelery count];
    return self;
}

- (id)initWithJewels:(NSInteger)index
{
	self.init;
	jewelIndex = index;// % jewelCount; // % (mod) used for safety check
	return self;
}

//increment jewelIndex
- (int)incrementIndex
{
	jewelIndex++;
	jewelIndex = jewelIndex;// % jewelCount; // % (mod) used for safety check
	return jewelIndex;
}


//get jewel index
- (int)jewelIndex
{
	return jewelIndex;
}

//set jewel index
-(void) setJewelIndex:(int)index
{
    jewelIndex = index;// % jewelCount;
}

//get jewel count
- (int)jewelCount
{
	//return jewelCount;
	return [jewelery count];
}

//get jewel
- (NSDictionary *)jewel
{
    NSDictionary *jewelDict = [jewelery objectAtIndex: jewelIndex];
	return jewelDict;
}

//get jewel name
- (NSString *)jewelName
{
    NSDictionary *jewelDict = [jewelery objectAtIndex: jewelIndex];
    NSString *jewelName = [jewelDict objectForKey:@"stone"];
	return jewelName;
}

//get color
- (NSString *)jewelColor
{
    NSDictionary *jewelDict = [jewelery objectAtIndex: jewelIndex];
    NSString *jewelColor = [jewelDict objectForKey:@"color"];
	return jewelColor;	
}

//get jewel description
- (NSString *)jewelDescription
{
    NSDictionary *jewelDict = [jewelery objectAtIndex: jewelIndex];
    NSString *jewelDescription = [jewelDict objectForKey:@"description"];
	return jewelDescription;
}

@end
