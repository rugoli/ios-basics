//
//  RGAnimationWrapper.m
//  RGAnimation
//
//  Created by Roshan Goli on 5/28/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGAnimationWrapper.h"

@implementation RGAnimationWrapper

- (instancetype)initWithAnimation:(CABasicAnimation *)animation
											isReversing:(BOOL)isReversing
{
	if (self = [super init]) {
		_animation = animation;
		_isReversing = isReversing;
	}
	return self;
}

@end
