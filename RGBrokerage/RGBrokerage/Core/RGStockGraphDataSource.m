//
//  RGStockGraphDataSource.m
//  RGBrokerage
//
//  Created by Roshan Goli on 6/15/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockGraphDataSource.h"

@implementation RGStockGraphDataSource {
	NSMutableArray<NSMutableArray<NSNumber *> *> *_fakeData;
}

- (instancetype)initWithDelegate:(id<RGStockDataSourceDelegate>)delegate
{
	if (self = [super init]) {
		_delegate = delegate;
		[self _generateFakeData];
	}
	return self;
}

- (void)_generateFakeData
{
	_fakeData = [@[[NSMutableArray new], [NSMutableArray new]] mutableCopy];
	
	dispatch_group_t blockGroup = dispatch_group_create();
	__weak __typeof(self) weakSelf = self;
	for (NSUInteger i = 0; i < 2; i++) {
		dispatch_group_async(blockGroup,
												 dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
												 ^{
													 [weakSelf _generateDataForLineIndex:i];
												 });
	}

	dispatch_group_notify(blockGroup, dispatch_get_main_queue(), ^{
		__strong __typeof(self) strongSelf = weakSelf;
		if (strongSelf) {
			[strongSelf->_delegate dataSourceDataHasFinishedLoading];
		}
	});
}

- (void)_generateDataForLineIndex:(NSUInteger)index
{
	NSMutableArray *lineData = [_fakeData objectAtIndex:index];
	[lineData insertObject:@(arc4random_uniform(20) + index + 1) atIndex:0];
	for (NSUInteger j = 1; j < 100; j++) {
		[lineData insertObject:@([[lineData objectAtIndex:j-1] floatValue] * [self _getRandomPercentageMultiplier]) atIndex:j];
	}
}

- (CGFloat)_getRandomPercentageMultiplier
{
	CGFloat randomPercent = (float)(arc4random_uniform(10) + 95);
	return randomPercent/100.00;
}

# pragma mark - JBLineChartViewDataSource methods

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
	return 2;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
	return 20;
}

# pragma mark - JBLineChartViewDelegate methods

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView
verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex
						 atLineIndex:(NSUInteger)lineIndex
{
	return arc4random_uniform(20);
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView
	 colorForLineAtLineIndex:(NSUInteger)lineIndex
{
	return lineIndex == 0 ? [UIColor greenColor] : [UIColor redColor];
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView
 widthForLineAtLineIndex:(NSUInteger)lineIndex
{
	return 1.0;
}

- (CGFloat)verticalSelectionWidthForLineChartView:(JBLineChartView *)lineChartView
{
	return 1.0;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView
verticalSelectionColorForLineAtLineIndex:(NSUInteger)lineIndex
{
	return [UIColor grayColor];
}

@end
