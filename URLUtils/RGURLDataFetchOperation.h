//
//  RGURLDataFetchOperation.h
//  RGURLConnection
//
//  Created by Roshan Goli on 4/9/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RGCustomNSOperation.h"

@protocol RGDataFetchParser

+ (NSArray<id> *)parseFetchedResults:(NSDictionary *)data;

@end

@interface RGURLDataFetchOperation : RGCustomNSOperation

typedef void (^RGDataFetchCallback)(NSArray *results);

- (instancetype)initWithURLSession:(NSURLSession *)session
											 searchQuery:(NSString *)searchQuery
												dataParser:(Class<RGDataFetchParser>)dataParser
										 callbackBlock:(RGDataFetchCallback)callbackBlock;

@end
