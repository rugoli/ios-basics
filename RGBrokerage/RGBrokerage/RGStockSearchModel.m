//
//  RGStockSearchModel.m
//  RGBrokerage
//
//  Created by Roshan Goli on 5/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockSearchModel.h"

@implementation RGStockSearchModel

- (instancetype)initWithSymbol:(NSString *)stockSymbol
								lastTradePrice:(NSString *)lastTradePrice
{
	if (self = [super init]) {
		_stockSymbol = [stockSymbol copy];
		_price = @([lastTradePrice floatValue]);
	}
	return self;
}

@end
