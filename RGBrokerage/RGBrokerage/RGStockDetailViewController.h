//
//  RGStockDetailViewController.h
//  RGBrokerage
//
//  Created by Roshan Goli on 6/6/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGStockSearchModel;

@interface RGStockDetailViewController : UIViewController

- (void)setStockModel:(RGStockSearchModel *)stockModel;

@property (nonatomic, readwrite, strong) IBOutlet UINavigationItem *navigationItem;

@end
