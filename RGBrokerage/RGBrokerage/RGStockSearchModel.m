//
//  RGStockSearchModel.m
//  RGBrokerage
//
//  Created by Roshan Goli on 5/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockSearchModel.h"

static NSString *const kStockSymbolField = @"Symbol";
static NSString *const kLastTradePriceField = @"LastTradePriceOnly";
static NSString *const kChangeinPercentField = @"ChangeinPercent";
static NSString	*const kCompanyNameField = @"Name";

@implementation RGStockSearchModel

- (instancetype)initWithStockResults:(NSDictionary *)stockResults
{
	if ([stockResults[kCompanyNameField] isEqual:[NSNull null]]) {
		return nil;
	}

	return [self initWithSymbol:stockResults[kStockSymbolField]
												 name:stockResults[kCompanyNameField]
							 lastTradePrice:stockResults[kLastTradePriceField]
							changeInPercent:stockResults[kChangeinPercentField]];
}

- (instancetype)initWithSymbol:(NSString *)stockSymbol
													name:(NSString *)companyName
								lastTradePrice:(NSString *)lastTradePrice
							 changeInPercent:(NSString *)changeInPercent
{
	if (self = [super init]) {
		_stockSymbol = [stockSymbol copy];
		_price = @([lastTradePrice floatValue]);
		_name = [companyName copy];
		_changeInPercent = [changeInPercent copy];
	}
	return self;
}

- (NSString *)description
{
	NSMutableArray<NSString *> *formattedString = [NSMutableArray new];
	for (NSString *field in StockModelDesiredFields()) {
		[formattedString addObject:[NSString stringWithFormat:@"%@ : %@", field, [self _fieldForProperty][field]]];
	}
	return [formattedString componentsJoinedByString:@"\n"];
}

- (NSDictionary*)_fieldForProperty
{
	return @{kCompanyNameField : _name,
					 kStockSymbolField : _stockSymbol,
					 kChangeinPercentField : _changeInPercent,
					 kLastTradePriceField : _price
					 };
}

NSArray<NSString *> *StockModelDesiredFields()
{
	return @[kStockSymbolField, kLastTradePriceField, kChangeinPercentField, kCompanyNameField];
}

@end
