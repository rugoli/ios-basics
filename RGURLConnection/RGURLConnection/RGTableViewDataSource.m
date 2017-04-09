//
//  RGTableViewDataSource.m
//  RGURLConnection
//
//  Created by Roshan Goli on 4/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RGTableViewDataSource.h"
#import "RGiTunesTableCellViewModel.h"
#import "RGTableViewCell.h"
#import "RGDataFetchOperation.h"

@interface RGTableViewDataSource () <NSURLSessionDelegate>

@property (atomic, readonly, assign) BOOL isFetching;
@property (atomic, readonly, assign) BOOL isCancelled; // if current data fetch has been canceled

@end

@implementation RGTableViewDataSource {
	NSMutableArray<RGiTunesTableCellViewModel *> *_results;
	NSString *_currentQuery;
	BOOL _isCancelled;
	
	NSString *_cellReuseIdentifier;
	
	NSURLSession *_urlSession;
	
	NSOperationQueue *_operationQueue;
	RGDataFetchOperation *_currentOperation;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
{
	if (self = [super init]) {
		_urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
																								delegate:self
																					 delegateQueue:[NSOperationQueue mainQueue]];
		_results = [NSMutableArray new];
		_isFetching = NO;
		_cellReuseIdentifier = [reuseIdentifier copy];
		
		_operationQueue = [NSOperationQueue new];
		_operationQueue.name = @"RG itunes data fetching";
		_operationQueue.qualityOfService = NSQualityOfServiceUserInitiated;
	}
	return self;
}

# pragma mark - Public methods

- (void)executeNewSearchQuery:(NSString *)query
{
	[_results removeAllObjects];
	_currentQuery = [query copy];
	if (_currentQuery.length > 0) {
		[self _searchWithCurrentQueryAndOffset];
	} else {
		[_delegate dataSourceFinishedFetch:self];
	}
}

- (void)_searchWithCurrentQueryAndOffset
{
	_currentOperation = [self _newOperationForCurrentQuery];
	[_operationQueue cancelAllOperations];
	[_operationQueue addOperation:_currentOperation];
}

- (RGDataFetchOperation *)_newOperationForCurrentQuery
{
	__weak __typeof(self) weakSelf = self;
	return [[RGDataFetchOperation alloc] initWithURLSession:_urlSession
																							searchQuery:[self _urlSearchQuery]
																						callbackBlock:^(NSArray<RGiTunesTableCellViewModel *> *results, RGDataFetchOperation *operation) {
																							[weakSelf _addNewResults:results
																												 fromOperation:operation];
																						}];
}

- (void)_addNewResults:(NSArray<RGiTunesTableCellViewModel *> *)results
				 fromOperation:(RGDataFetchOperation *)operation
{
	if (!results || operation != _currentOperation) {
		return;
	}
	__weak __typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		__strong __typeof(self) strongSelf = weakSelf;
		if (strongSelf) {
			[_results addObjectsFromArray:results];
			[strongSelf->_delegate dataSourceFinishedFetch:strongSelf];
		}
	});
}

-(NSString *)_urlSearchQuery
{
	return [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=20&offset=%lu", _currentQuery, (unsigned long)_results.count];
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

# pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return [_results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
				 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (!_isFetching && indexPath.row >= _results.count - 10) {
		[self _searchWithCurrentQueryAndOffset];
	}
	
	RGiTunesTableCellViewModel *const viewModel = [_results objectAtIndex:indexPath.row];
	RGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellReuseIdentifier];
	if (cell) {
		[cell configureWithNewViewModel:viewModel];
	} else {
		cell = [RGTableViewCell newWithViewModel:viewModel];
	}
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

# pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 44.0;
}

@end
