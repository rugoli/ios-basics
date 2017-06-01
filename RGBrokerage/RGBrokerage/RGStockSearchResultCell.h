//
//  RGStockSearchResultCell.h
//  RGBrokerage
//
//  Created by Roshan Goli on 5/31/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGStockSearchResultCell : UIView

@property (nonatomic, readwrite, strong) IBInspectable UILabel *companyName;
@property (nonatomic, readwrite, strong) IBInspectable UILabel *stockSymbol;
@property (nonatomic, readwrite, strong) IBInspectable UILabel *stockPrice;
@property (nonatomic, readwrite, strong) IBInspectable UILabel *changeInPercent;

@end
