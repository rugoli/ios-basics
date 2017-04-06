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
		_cellReuseIdentifier = [reuseIdentifier copy];
	}
	return self;
}

# pragma mark - Public methods

- (void)executeSearchQuery:(NSString *)query
{
	if (query.length > 0) {
		__typeof (self) weakSelf = self;
		NSURLSessionDataTask *downloadTask = [_urlSession dataTaskWithURL:[NSURL URLWithString:UrlQueryForSearchTerm(query)]
																									 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
																										 if (error) {
																											 NSLog(@"Oh no, an error: %@", error.description);
																											 return;
																										 }
																										 [weakSelf handleDownloadWithData:data response:response];
																									 }];
		[downloadTask resume];
	}
}

static NSString *UrlQueryForSearchTerm(NSString *query)
{
	return [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@", query];
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
	[_results removeAllObjects];
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
																																							author:result[@"artistName"]]];
	}];
	[_delegate dataSourceFinishedFetch:self];
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

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView
				 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	RGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellReuseIdentifier];
	RGiTunesTableCellViewModel *const viewModel = [_results objectAtIndex:indexPath.row];
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
