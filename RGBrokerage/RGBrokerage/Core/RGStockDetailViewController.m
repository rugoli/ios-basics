//
//  RGStockDetailViewController.m
//  RGBrokerage
//
//  Created by Roshan Goli on 6/6/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockDetailViewController.h"
#import "RGStockSearchModel.h"
#import "RGURLDataFetcher.h"
#import "RGBrokerageYahooFinanceDataParser.h"

@interface RGStockDetailViewController () <RGDataFetcherDelegate>
@end

@implementation RGStockDetailViewController {
	RGStockSearchModel *_stockModel;
	RGURLDataFetcher *_dataFetcher;
}

- (void)loadView
{
	[super loadView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
	[self.navigationController.navigationBar setTintColor:[UIColor greenColor]];
}

- (void)initializeDataFetcher
{
	_dataFetcher = [[RGURLDataFetcher alloc] initWithQueueName:@"stock detail fetcher"
																									dataParser:[RGBrokerageYahooFinanceDataParser class]];
	_dataFetcher.delegate = self;
}

- (void)setStockModel:(RGStockSearchModel *)stockModel
{
	_stockModel = stockModel;
	
	_navigationItem.title = stockModel.stockSymbol;
}

- (IBAction)didTapCancel:(id)sender
{
	[self dismissViewControllerAnimated:self completion:nil];
}
	 
# pragma mark - RGDataFetcher helpers
	 
static NSString *sqlQueryForStockSymbol(NSString *stockSymbol)
{
	return [NSString stringWithFormat:@"select %@ from yahoo.finance.quotes where symbol IN ('%@')",
				[StockModelDesiredFields() componentsJoinedByString:@", "],
				stockSymbol];
}

static NSString *apiQueryForStockSymbol(NSString *stockSymbol)
{
	return [[NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=%@&format=json&diagnostics=true&env=store://datatables.org/alltableswithkeys", sqlQueryForStockSymbol(stockSymbol)] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

# pragma mark - RGDataFetcherDelegate methods

- (void)dataFetcherDidFinishWithResults:(NSArray<id> *)results
															 forQuery:(NSString *)query
{
	NSLog(@"testing");
}

@end
