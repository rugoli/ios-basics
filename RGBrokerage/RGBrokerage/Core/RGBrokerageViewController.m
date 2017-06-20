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
#import "RGStockDetailViewController.h"
#import "RGStockSearchResultCell.h"

@interface RGBrokerageViewController ()
<
	UISearchBarDelegate,
	RGDataFetcherDelegate,
	RGStockSearchResultCellDelegate
>
@end

@implementation RGBrokerageViewController {
	RGMainCollectionView *_mainView;
	
	RGURLDataFetcher *_dataFetcher;
	
	RGStockSearchModel *_selectedStock;
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
	NSString *const uppercaseSearch = searchText.uppercaseString;
	searchBar.text = [uppercaseSearch copy];
	if (uppercaseSearch.length > 0) {
		[_dataFetcher executeQuery:apiQueryForSearchTerm(uppercaseSearch)];
	} else {
		[self _configureResultCellWithStockModel:nil];
	}
	
}

- (void)_configureResultCellWithStockModel:(RGStockSearchModel *)stockModel
{
	if (stockModel == nil) {
		_searchResultsCell.hidden = YES;
		return;
	}
	
	[_searchResultsCell configureWithStockSearchModel:stockModel];
	_searchResultsCell.hidden = NO;
}

static NSString *sqlQueryForSearchTerm(NSString *searchTerm)
{
	return [NSString stringWithFormat:@"select %@ from yahoo.finance.quotes where symbol IN ('%@')",
					[[RGStockSearchModel stockModelDesiredFieldNames] componentsJoinedByString:@", "],
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
	if (results.count == 0 || ![[results objectAtIndex:0] isKindOfClass:[RGStockSearchModel class]]) {
		[self _configureResultCellWithStockModel:nil];
		return;
	}
	
	[self _configureResultCellWithStockModel:(RGStockSearchModel *)[results objectAtIndex:0]];
}

# pragma mark RGStockSearchResultCellDelegate methods

- (void)didSelectSearchResultCell:(RGStockSearchResultCell *)cell
												withModel:(RGStockSearchModel *)model
{
	_selectedStock = model;
	[self performSegueWithIdentifier:@"SearchToDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
								 sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"SearchToDetail"]) {
		UINavigationController *navController = [segue destinationViewController];

		RGStockDetailViewController *stockDetailVC = (RGStockDetailViewController *)navController.topViewController;
		[stockDetailVC setStockModel:_selectedStock];
		[stockDetailVC generateFakeData];
	}
}

@end
