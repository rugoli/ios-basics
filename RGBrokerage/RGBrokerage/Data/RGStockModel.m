//
//  RGStockSearchModel.m
//  RGBrokerage
//
//  Created by Roshan Goli on 5/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockModel.h"

@implementation RGStockModel

- (instancetype)initWithStockResults:(NSDictionary *)stockResults
{
	__block BOOL missingRequiredField = NO;
	[[[self class] requiredFieldNames] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([stockResults[obj] isEqual:[NSNull null]]) {
			*stop = YES;
			missingRequiredField = YES;
		}
	}];
	return missingRequiredField ? nil : [self initWithSanitizedResults:stockResults];
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

+ (NSArray<NSString *> *)requiredFieldNames
{
	NSLog(@"Must be defined by children");
	return @[];
}


@end
