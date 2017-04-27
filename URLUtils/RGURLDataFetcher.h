//
//  RGURLDataFetcher.h
//  RGURLConnection
//
//  Created by Roshan Goli on 4/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RGDataFetcherDelegate

- (void)dataFetcherDidFinishWithResults:(NSArray<id> *)results
															 forQuery:(NSString *)query;

@end

@interface RGURLDataFetcher : NSObject

- (instancetype)initWithQueueName:(NSString *)queueName;

- (void)executeQuery:(NSString *)query;

@property (nonatomic, readwrite, weak) id<RGDataFetcherDelegate> delegate;

@end
