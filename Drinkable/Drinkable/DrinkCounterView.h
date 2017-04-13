//
//  DrinkCounterView.h
//  Drinkable
//
//  Created by Roshan Goli on 4/12/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface DrinkCounterView : UIView

@property (nonatomic, readonly, strong) IBInspectable UIColor *arcColor;
@property (nonatomic, readonly, strong) IBInspectable UIColor *outlineColor;
@property (nonatomic, readwrite, assign) int counter;

@end
