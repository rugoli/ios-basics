//
//  RGBrokerageViewController.m
//  RGBrokerage
//
//  Created by Roshan Goli on 4/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGBrokerageViewController.h"

#import "RGMainCollectionView.h"
#import "RGBrokerageSearchBar.h"
#import "RGURLDataFetcher.h"
#import "RGBrokerageYahooFinanceDataParser.h"
#import "RGStockSearchModel.h"
<<<<<<< HEAD
=======
#import "RGStockSearchResultCell.h"
>>>>>>> 2c8e3cf44c786da66e25c8ceb706ba4d687dac20

@interface RGBrokerageViewController () <UISearchBarDelegate, RGDataFetcherDelegate>
@end

@implementation RGBrokerageViewController {
	RGMainCollectionView *_mainView;
	
	RGURLDataFetcher *_dataFetcher;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		_dataFetcher = [[RGURLDataFetcher alloc] initWithQueueName:@"stocks fetcher"
																										dataParser:[RGBrokerageYahooFinanceDataParser class]];
		_dataFetcher.delegate = self;
	}
	return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

# pragma mark - UISearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if (searchText.length > 0) {
		[_dataFetcher executeQuery:apiQueryForSearchTerm(searchText)];
	} else {
		[self _configureSearchResultCellWithModel:nil];
	}
}

- (void)_configureSearchResultCellWithModel:(RGStockSearchModel *)stockModel
{
	if (stockModel == nil) {
		_searchResultsCell.hidden = YES;
		return;
	}

	[_searchResultsCell.companyName setText:stockModel.name];
	[_searchResultsCell.stockSymbol setText:stockModel.stockSymbol];
	_searchResultsCell.hidden = NO;
}

static NSString *sqlQueryForSearchTerm(NSString *searchTerm)
{
	return [NSString stringWithFormat:@"select %@ from yahoo.finance.quotes where symbol IN ('%@')",
					[StockModelDesiredFields() componentsJoinedByString:@", "],
					searchTerm];
}

static NSString *apiQueryForSearchTerm(NSString *searchTerm)
{
	return [[NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=%@&format=json&diagnostics=true&env=store://datatables.org/alltableswithkeys", sqlQueryForSearchTerm(searchTerm)] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

# pragma mark RGDataFetcherDelegate methods

- (void)dataFetcherDidFinishWithResults:(NSArray<id> *)results
															 forQuery:(NSString *)query
{
<<<<<<< HEAD
	
=======
	if (![[results objectAtIndex:0] isKindOfClass:[RGStockSearchModel class]]) {
		return;
	}
	
	[self _configureSearchResultCellWithModel:(RGStockSearchModel *)[results objectAtIndex:0]];
>>>>>>> 2c8e3cf44c786da66e25c8ceb706ba4d687dac20
}

@end
