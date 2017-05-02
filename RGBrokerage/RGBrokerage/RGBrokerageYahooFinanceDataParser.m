//
//  RGBrokerageYahooFinanceDataParser.m
//  RGBrokerage
//
//  Created by Roshan Goli on 4/27/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGBrokerageYahooFinanceDataParser.h"

#import "RGStockSearchModel.h"

@implementation RGBrokerageYahooFinanceDataParser

+ (NSArray *)parseFetchedResults:(NSDictionary *)data
{
	NSDictionary *const results = [(NSDictionary *)[(NSDictionary *)[data objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"quote"];
	
	__block NSMutableArray *parsedResults = [NSMutableArray new];
//	[results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//		NSDictionary *result = (NSDictionary *)obj;
//		if (![result isKindOfClass:[NSDictionary class]]) {
//			return;
//		}
//		[parsedResults addObject:[[RGStockSearchModel alloc] initWithSymbol:result[@"symbol"]
//																												 lastTradePrice:result[@"LastTradePriceOnly"]]];
//	}];
//	
//	return parsedResults;
	return [NSArray new];
}

@end
