//
//  RGStockGraphDataSource.m
//  RGBrokerage
//
//  Created by Roshan Goli on 6/15/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockGraphDataSource.h"

@implementation RGStockGraphDataSource

- (instancetype)init
{
	if (self = [super init]) {
	}
	return self;
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
	return 2.0;
}

@end
