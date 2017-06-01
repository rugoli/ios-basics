//
//  RGBrokerageViewController.h
//  RGBrokerage
//
//  Created by Roshan Goli on 4/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGBrokerageSearchBar;
@class RGStockSearchResultCell;

@interface RGBrokerageViewController : UIViewController

@property (nonatomic, readwrite, weak) IBOutlet RGBrokerageSearchBar *searchBar;
@property (nonatomic, readwrite, weak) IBOutlet RGStockSearchResultCell *searchResultsCell;

@end

