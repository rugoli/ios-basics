//
//  RGDataFetchOperation.h
//  RGURLConnection
//
//  Created by Roshan Goli on 4/9/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RGCustomNSOperation.h"

@class RGiTunesTableCellViewModel;

@interface RGDataFetchOperation : RGCustomNSOperation

typedef void (^RGDataFetchCallback)(NSArray<RGiTunesTableCellViewModel *> *results, RGDataFetchOperation *operation);

- (instancetype)initWithURLSession:(NSURLSession *)session
											 searchQuery:(NSString *)searchQuery
										 callbackBlock:(RGDataFetchCallback)callbackBlock;

@end
