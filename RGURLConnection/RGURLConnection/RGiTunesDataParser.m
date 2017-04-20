//
//  RGiTunesDataParser.m
//  RGURLConnection
//
//  Created by Roshan Goli on 4/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGiTunesDataParser.h"

#import "RGiTunesTableCellViewModel.h"

@implementation RGiTunesDataParser

+ (NSArray<id> *)parseFetchedResults:(NSDictionary *)data
{
	NSArray *const results = (NSArray *)[data objectForKey:@"results"];

	__block NSMutableArray *parsedResults = [NSMutableArray new];
	[results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		NSDictionary *result = (NSDictionary *)obj;
		if (![result isKindOfClass:[NSDictionary class]]) {
			return;
		}
		[parsedResults addObject:[[RGiTunesTableCellViewModel alloc] initWithName:result[@"trackName"]
																																			 author:result[@"artistName"]
																																		 imageURL:result[@"artworkUrl30"]]];
	}];
	
	return parsedResults;
}


@end
