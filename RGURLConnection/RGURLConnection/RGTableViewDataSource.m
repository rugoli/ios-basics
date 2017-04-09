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

@interface RGTableViewDataSource () <NSURLSessionDelegate>
@end

@implementation RGTableViewDataSource {
	NSMutableArray<RGiTunesTableCellViewModel *> *_results;
	NSString *_currentQuery;
	BOOL _isFetching;
	BOOL _isCancelled;  // if current data fetch has been canceled
	
	NSString *_cellReuseIdentifier;
	
	NSURLSession *_urlSession;
	
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

- (void)_fetchMoreResults
{
	[self _searchWithCurrentQueryAndOffset];
}

- (void)_searchWithCurrentQueryAndOffset
{
	__typeof (self) weakSelf = self;
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
		__strong __typeof(self) strongSelf = weakSelf;
		if (strongSelf) {
			NSURLSessionDataTask *downloadTask = [_urlSession dataTaskWithURL:[NSURL URLWithString:[strongSelf _urlSearchQuery]]
																											completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
																												if (error) {
																													NSLog(@"Oh no, an error: %@", error.description);
																													return;
																												}
																												[weakSelf handleDownloadWithData:data response:response];
																											}];
			strongSelf->_isFetching = YES;
			[downloadTask resume];
		}
	});
}

-(NSString *)_urlSearchQuery
{
	return [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=20&offset=%lu", _currentQuery, (unsigned long)_results.count];
}

- (void)handleDownloadWithData:(NSData *)data
											response:(NSURLResponse *)response
{
	NSError *error;
	NSDictionary *const dict = [NSJSONSerialization JSONObjectWithData:data
																														 options:NSJSONReadingMutableContainers
																															 error:&error];
	if (!error) {
		NSArray *const results = (NSArray *)[dict objectForKey:@"results"];
		[self generateViewModelsFromResults:results];
	} else {
		NSLog(@"Oh no, an error: %@", [error localizedDescription]);
	}
}

- (void)generateViewModelsFromResults:(NSArray *)results
{
	__weak __typeof(self) weakSelf = self;
	[results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		__strong __typeof(self) strongSelf = weakSelf;
		if (!strongSelf) {
			return;
		}
		NSDictionary *result = (NSDictionary *)obj;
		if (![result isKindOfClass:[NSDictionary class]]) {
			return;
		}
		[strongSelf->_results addObject:[[RGiTunesTableCellViewModel alloc] initWithName:result[@"trackName"]
																																							author:result[@"artistName"]
																																						imageURL:result[@"artworkUrl30"]]];
	}];

	dispatch_async(dispatch_get_main_queue(), ^{
		__strong __typeof(self) strongSelf = weakSelf;
		if (strongSelf) {
			strongSelf->_isFetching = NO;
			[_delegate dataSourceFinishedFetch:strongSelf];
		}
	});
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
		[self _fetchMoreResults];
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
