//
//  RGStockSearchModel.h
//  RGBrokerage
//
//  Created by Roshan Goli on 5/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGStockSearchModel : NSObject

- (instancetype)initWithSymbol:(NSString *)stockSymbol
								lastTradePrice:(NSString *)lastTradePrice;

@property (nonatomic, readonly, copy) NSString *stockSymbol;
@property (nonatomic, readonly, strong) NSNumber *price;

@end
