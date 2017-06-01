//
//  RGStockSearchResultCell.h
//  RGBrokerage
//
//  Created by Roshan Goli on 5/31/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGStockSearchResultCell : UIView

@property (nonatomic, readwrite, strong) IBOutlet UILabel *companyName;
@property (nonatomic, readwrite, strong) IBOutlet UILabel *stockSymbol;
@property (nonatomic, readwrite, strong) IBOutlet UILabel *stockPrice;
@property (nonatomic, readwrite, strong) IBOutlet UILabel *changeInPercent;

@end
