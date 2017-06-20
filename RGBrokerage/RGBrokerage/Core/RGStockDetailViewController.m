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
#import "JBLineChartView.h"
#import "RGStockGraphDataSource.h"
#import "RGSelectedPointDetailView.h"

@interface RGStockDetailViewController () <RGDataFetcherDelegate, RGStockDataSourceDelegate>

@property (atomic, readwrite, assign) BOOL graphDidLayout;
@property (atomic, readwrite, assign) BOOL dataLoadFinished;

@end

@implementation RGStockDetailViewController {
	RGStockSearchModel *_stockModel;
	RGURLDataFetcher *_dataFetcher;
	
	RGStockGraphDataSource *_graphDataSource;
}

- (void)dealloc
{
	_graphView.dataSource = nil;
	_graphView.delegate = nil;
}

- (void)loadView
{
	[super loadView];
	
	[_pointDetailView setHidden:YES];
	
//	[_dataFetcher executeQuery:apiQueryForStockSymbol(_stockModel.stockSymbol)];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
	[self.navigationController.navigationBar setTranslucent:YES];
	[self.navigationController.navigationBar setTintColor:[UIColor greenColor]];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	self.graphDidLayout = YES;
	if (self.dataLoadFinished) {
		[self _configureGraphViewAndReload];
	}
}

# pragma mark - Public methods

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

- (void)generateFakeData
{
	_graphDataSource = [[RGStockGraphDataSource alloc] initWithDelegate:self];
}

# pragma mark - Navigation

- (IBAction)didTapCancel:(id)sender
{
	[self dismissViewControllerAnimated:self completion:nil];
}
	 
# pragma mark - RGDataFetcher helpers
	 
//static NSString *sqlQueryForStockSymbol(NSString *stockSymbol)
//{
//	return [NSString stringWithFormat:@"select %@ from yahoo.finance.quotes where symbol IN ('%@')",
//				[[RGStockSearchModel stockModelDesiredFieldNames] componentsJoinedByString:@", "],
//				stockSymbol];
//}
//
//static NSString *apiQueryForStockSymbol(NSString *stockSymbol)
//{
//	return [[NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=%@&format=json&diagnostics=true&env=store://datatables.org/alltableswithkeys", sqlQueryForStockSymbol(stockSymbol)] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
//}

# pragma mark - RGDataFetcherDelegate methods

- (void)dataFetcherDidFinishWithResults:(NSArray<id> *)results
															 forQuery:(NSString *)query
{
	NSLog(@"testing");
}

- (void)lineChartView:(JBLineChartView *)lineChartView
didSelectLineWithValue:(NSNumber *)value
						lineColor:(UIColor *)lineColor
						 lineName:(NSString *)lineName
				 atTouchPoint:(CGPoint)touchPoint
{
	[_pointDetailView setQuoteLabelValue:FormattedStringFromQuoteValue(value)];
	[_pointDetailView setQuoteLabelColor:lineColor];
	
	[_pointDetailView setQuoteNameValue:lineName];
	[_pointDetailView setQuoteNameColor:lineColor];
	
	[_pointDetailView sizeToFit];
	[_pointDetailView setHidden:NO];
}

- (void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView
{
	[_pointDetailView setHidden:YES];
}

- (void)_configureGraphViewAndReload
{
	_graphView.dataSource = _graphDataSource;
	_graphView.delegate = _graphDataSource;
	_graphView.headerView = _pointDetailView;
	[_graphView reloadData];
}

static NSString *FormattedStringFromQuoteValue(NSNumber *quoteValue)
{
	NSNumberFormatter *formatter = [NSNumberFormatter new];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	return [formatter stringFromNumber:quoteValue];
}

# pragma mark - RGStockDataSourceDelegate methods

- (void)dataSourceDataHasFinishedLoading
{
	self.dataLoadFinished = YES;
	if (self.graphDidLayout) {
		[self _configureGraphViewAndReload];
	}
}

@end
