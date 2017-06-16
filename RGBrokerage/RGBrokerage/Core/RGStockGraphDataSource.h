//
//  RGStockGraphDataSource.h
//  RGBrokerage
//
//  Created by Roshan Goli on 6/15/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBLineChartView.h"

@protocol RGStockDataSourceDelegate

- (void)dataSourceDataHasFinishedLoading;

@end

@interface RGStockGraphDataSource : NSObject <JBLineChartViewDataSource, JBLineChartViewDelegate>

- (instancetype)initWithDelegate:(id<RGStockDataSourceDelegate>)delegate;

@property (nonatomic, readonly, weak) id<RGStockDataSourceDelegate> delegate;

@end
