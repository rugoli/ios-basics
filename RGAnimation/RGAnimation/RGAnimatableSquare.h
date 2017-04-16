//
//  RGAnimatableSquare.h
//  RGAnimation
//
//  Created by Roshan Goli on 4/16/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface RGAnimatableSquare : UIView

@property (nonatomic, strong, readonly) IBInspectable UIColor *squareColor;
@property (nonatomic, strong, readonly) IBInspectable NSNumber *dimension;

@end
