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

- (instancetype)initWithSanitizedResults:(NSDictionary *)sanitizedResults
{
	return [self initWithSymbol:sanitizedResults[kStockSymbolField]
												 name:sanitizedResults[kCompanyNameField]
							 lastTradePrice:sanitizedResults[kLastTradePriceField]
							changeInPercent:sanitizedResults[kChangeinPercentField]];
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

- (NSDictionary*)fieldToPropertyMapping
{
	return @{kCompanyNameField : _name,
					 kStockSymbolField : _stockSymbol,
					 kChangeinPercentField : _changeInPercent,
					 kLastTradePriceField : _price
					 };
}

+ (NSArray<NSString *> *)stockModelDesiredFieldNames
{
	return @[kStockSymbolField, kLastTradePriceField, kChangeinPercentField, kCompanyNameField];
}

+ (NSArray<NSString *> *)requiredFieldNames
{
	return @[kLastTradePriceField, kCompanyNameField];
}

@end
