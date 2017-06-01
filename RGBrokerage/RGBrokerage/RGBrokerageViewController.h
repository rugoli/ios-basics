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
<<<<<<< HEAD
@property (nonatomic, readwrite, weak) IBOutlet UIView *searchResultsCell;
=======
@property (nonatomic, readwrite, weak) IBOutlet RGStockSearchResultCell *searchResultsCell;
>>>>>>> 2c8e3cf44c786da66e25c8ceb706ba4d687dac20

@end

