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
	NSMutableArray<NSMutableArray<NSNumber *> *> *_normalizedData;
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
	_normalizedData = [@[[NSMutableArray new], [NSMutableArray new]] mutableCopy];
	
	dispatch_group_t blockGroup = dispatch_group_create();
	__weak __typeof(self) weakSelf = self;
	for (NSUInteger i = 0; i < 2; i++) {
		dispatch_group_async(blockGroup,
												 dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
													 __strong __typeof(self) strongSelf = weakSelf;
													 [strongSelf _generateDataForLineIndex:i];
													 [strongSelf _normalizeDataForLineIndex:i];
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
	for (NSUInteger j = 1; j < 500; j++) {
		[lineData insertObject:@([[lineData objectAtIndex:j-1] floatValue] * [self _getRandomPercentageMultiplier]) atIndex:j];
	}
}

/* I could have just normalized it from the beginning in _generateDataForLineIndex above,
 * but in the future I will probably have real stock data that comes down all at once
 * so I need to have a function that normalizes an array of numbers anyways.
*/
- (void)_normalizeDataForLineIndex:(NSUInteger)index
{
	NSMutableArray<NSNumber *> *lineData = [_fakeData objectAtIndex:index];
	NSMutableArray<NSNumber *> *normalizedData = [_normalizedData objectAtIndex:index];
	if ([[lineData objectAtIndex:0] floatValue] - 0 < 0.0001) {
		return;
	}
	
	for (NSUInteger i = 0; i < [lineData count]; i++) {
		[normalizedData addObject:@(100.0 * [[lineData objectAtIndex:i] floatValue] / [[lineData objectAtIndex:0] floatValue])];
	}
}

- (CGFloat)_getRandomPercentageMultiplier
{
	CGFloat randomPercent = (float)(arc4random_uniform(10) + 95.5);
	return randomPercent/100.00;
}

# pragma mark - JBLineChartViewDataSource methods

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
	return 2;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
	return [[_fakeData objectAtIndex:lineIndex] count];
}

# pragma mark - JBLineChartViewDelegate methods

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView
verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex
						 atLineIndex:(NSUInteger)lineIndex
{
	return [[[_normalizedData objectAtIndex:lineIndex] objectAtIndex:horizontalIndex] floatValue];
}

- (NSNumber *)_realVerticalValueForHorizontalIndex:(NSUInteger)horizontalIndex
																		atLineIndex:(NSUInteger)lineIndex
{
	return [[_fakeData objectAtIndex:lineIndex] objectAtIndex:horizontalIndex];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView
	 colorForLineAtLineIndex:(NSUInteger)lineIndex
{
	return lineIndex == 0 ? [UIColor greenColor] : [UIColor redColor];
}

- (NSString *)_nameForLineAtIndex:(NSUInteger)lineIndex
{
	return lineIndex == 0 ? @"Green" : @"Red";
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

- (void)lineChartView:(JBLineChartView *)lineChartView
 didSelectLineAtIndex:(NSUInteger)lineIndex
			horizontalIndex:(NSUInteger)horizontalIndex
					 touchPoint:(CGPoint)touchPoint
{
	[_delegate lineChartView:lineChartView
		didSelectLineWithValue:[self _realVerticalValueForHorizontalIndex:horizontalIndex
																													atLineIndex:lineIndex]
								 lineColor:[self lineChartView:lineChartView
											 colorForLineAtLineIndex:lineIndex]
									lineName:[self _nameForLineAtIndex:lineIndex]
							atTouchPoint:touchPoint];
}

- (void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView
{
	[_delegate didDeselectLineInLineChartView:lineChartView];
}

@end
