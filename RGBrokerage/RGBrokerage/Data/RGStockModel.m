//
//  RGStockSearchModel.m
//  RGBrokerage
//
//  Created by Roshan Goli on 5/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockModel.h"

static NSString *const kStockSymbolField = @"Symbol";
static NSString *const kLastTradePriceField = @"LastTradePriceOnly";
static NSString *const kChangeinPercentField = @"ChangeinPercent";
static NSString	*const kCompanyNameField = @"Name";

@implementation RGStockModel

- (instancetype)initWithStockResults:(NSDictionary *)stockResults
{
	if ([stockResults[kCompanyNameField] isEqual:[NSNull null]] ||
			[stockResults[kLastTradePriceField] isEqual:[NSNull null]]) {
		return nil;
	}

	return [self initWithSanitizedResults:stockResults];
}

- (instancetype)initWithSanitizedResults:(NSDictionary *)sanitizedResults
{
	NSLog(@"Must be defined by children");
	return [super init];
}

- (NSString *)description
{
	NSMutableArray<NSString *> *formattedString = [NSMutableArray new];
	for (NSString *field in [[self class] stockModelDesiredFieldNames]) {
		[formattedString addObject:[NSString stringWithFormat:@"%@ : %@", field, [self fieldToPropertyMapping][field]]];
	}
	return [formattedString componentsJoinedByString:@"\n"];
}

- (NSDictionary *)fieldToPropertyMapping
{
	NSLog(@"Must be defined by children");
	return @{};
}

+ (NSArray<NSString *> *)stockModelDesiredFieldNames
{
	NSLog(@"Must be defined by children");
	return nil;
}


@end
