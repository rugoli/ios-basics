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
	
	RGStockSearchModel *const stockModel = [[RGStockSearchModel alloc] initWithStockResults:results];
	return stockModel != nil
		? @[stockModel]
		: [NSArray new];
}

@end
