//
//  RGURLDataFetcher.m
//  RGURLConnection
//
//  Created by Roshan Goli on 4/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGURLDataFetcher.h"
#import "RGDataFetchOperation.h"

@interface RGURLDataFetcher () <NSURLSessionDelegate>
@end

@implementation RGURLDataFetcher {
	NSURLSession *_urlSession;
	
	NSOperationQueue *_operationQueue;
	RGDataFetchOperation *_currentOperation;
	
	NSString *_currentQuery;
}

- (instancetype)init
{
	if (self = [super init]) {
		_urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
																								delegate:self
																					 delegateQueue:[NSOperationQueue mainQueue]];
		
		_operationQueue = [NSOperationQueue new];
		_operationQueue.name = @"RG itunes data fetching";
		_operationQueue.qualityOfService = NSQualityOfServiceUserInitiated;
	}
	return self;
}

- (void)executeQuery:(NSString *)query
{
	_currentQuery = [query copy];
	if (_currentQuery.length > 0) {
		[self _searchWithCurrentQuery];
	} else {
		[_delegate dataFetcherDidFinishWithResults:[NSArray new]
																			forQuery:query];
	}
}

- (void)_searchWithCurrentQuery
{
	_currentOperation = [self _newOperationForCurrentQuery];
	[_operationQueue cancelAllOperations];
	[_operationQueue addOperation:_currentOperation];
}

- (RGDataFetchOperation *)_newOperationForCurrentQuery
{
	__weak __typeof(self) weakSelf = self;
	return [[RGDataFetchOperation alloc] initWithURLSession:_urlSession
																							searchQuery:_currentQuery
																						callbackBlock:^(NSArray<RGiTunesTableCellViewModel *> *results, RGDataFetchOperation *operation) {
																							__strong __typeof(self) strongSelf = weakSelf;
																							if (strongSelf) {
																								[strongSelf->_delegate dataFetcherDidFinishWithResults:results
																																															forQuery:strongSelf->_currentQuery];
																							}
																						}];
}

# pragma mark - NSURLSessionDelegate methods

- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
	completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error
{
	NSLog(@"test");
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
	NSLog(@"test");
}

@end
