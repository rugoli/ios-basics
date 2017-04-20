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
#import "RGURLDataFetcher.h"

@interface RGTableViewDataSource () <RGDataFetcherDelegate>

@property (atomic, readonly, assign) BOOL isFetching;
@property (atomic, readonly, assign) BOOL isCancelled; // if current data fetch has been canceled

@end

@implementation RGTableViewDataSource {
	NSMutableArray<RGiTunesTableCellViewModel *> *_results;
	NSString *_currentQuery;
	BOOL _isCancelled;
	
	NSString *_cellReuseIdentifier;
	
	RGURLDataFetcher *_dataFetcher;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
{
	if (self = [super init]) {
		_dataFetcher = [[RGURLDataFetcher alloc] init];
		_dataFetcher.delegate = self;

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
		[_dataFetcher executeQuery:[self _urlSearchQuery]];
	} else {
		[_delegate dataSourceFinishedFetch:self];
	}
}

# pragma mark - RGDataFetcherDelegate methods

- (void)dataFetcherDidFinishWithResults:(NSArray<id> *)results
															 forQuery:(NSString *)query
{
	if (!results || ![query isEqualToString:[self _urlSearchQuery]]) {
		return;
	}
	
	NSArray<RGiTunesTableCellViewModel *> *typedResults = (NSArray<RGiTunesTableCellViewModel *> *)results;
	
	__weak __typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		__strong __typeof(self) strongSelf = weakSelf;
		if (strongSelf) {
			[_results addObjectsFromArray:typedResults];
			[strongSelf->_delegate dataSourceFinishedFetch:strongSelf];
		}
	});
}

-(NSString *)_urlSearchQuery
{
	return [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=20&offset=%lu&media=music", _currentQuery, (unsigned long)_results.count];
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
		[_dataFetcher executeQuery:[self _urlSearchQuery]];
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
