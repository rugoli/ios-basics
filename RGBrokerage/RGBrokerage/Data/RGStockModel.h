//
//  RGStockModel.h
//  RGBrokerage
//
//  Created by Roshan Goli on 5/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGStockModel : NSObject

- (instancetype)initWithStockResults:(NSDictionary *)stockResults;

+ (NSArray<NSString *> *)stockModelDesiredFieldNames;

@end
