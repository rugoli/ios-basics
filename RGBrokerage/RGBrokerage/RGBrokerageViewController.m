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

@interface RGBrokerageViewController () <UISearchBarDelegate>
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
	[_dataFetcher executeQuery:apiQueryForSearchTerm(searchText)];
}

static NSString *sqlQueryForSearchTerm(NSString *searchTerm)
{
	return [NSString stringWithFormat:@"select * from yahoo.finance.quotes where symbol IN ('%@')", searchTerm];
}

static NSString *apiQueryForSearchTerm(NSString *searchTerm)
{
	return [[NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=%@&format=json&diagnostics=true&env=store://datatables.org/alltableswithkeys", sqlQueryForSearchTerm(searchTerm)] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

@end
