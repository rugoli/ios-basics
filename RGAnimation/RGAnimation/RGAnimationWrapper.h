//
//  RGAnimationWrapper.h
//  RGAnimation
//
//  Created by Roshan Goli on 5/28/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CABasicAnimation;

@interface RGAnimationWrapper : NSObject

- (instancetype)initWithAnimation:(CABasicAnimation *)animation
											isReversing:(BOOL)isReversing;

@property (atomic, readonly, assign) BOOL isReversing;
@property (atomic, readonly, strong) CABasicAnimation *animation;

@end
