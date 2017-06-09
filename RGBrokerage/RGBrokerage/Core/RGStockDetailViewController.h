//
//  RGStockDetailViewController.h
//  RGBrokerage
//
//  Created by Roshan Goli on 6/6/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGStockSearchModel;
@class RGStockDetailGraphView;

@interface RGStockDetailViewController : UIViewController

- (void)setStockModel:(RGStockSearchModel *)stockModel;
- (void)initializeDataFetcher;

@property (nonatomic, readwrite, weak) IBOutlet UINavigationItem *navigationItem;
@property (nonatomic, readwrite, weak) IBOutlet RGStockDetailGraphView *graphView;

@end
