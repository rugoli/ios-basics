//
//  RGCornerViewModel.m
//  RGAnimation
//
//  Created by Roshan Goli on 4/16/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGCornerViewModel.h"

@implementation RGCornerViewModel

- (instancetype)initWithPoint:(CGPoint)point
										 xyOffset:(CGPoint)xyOffset
{
	if (self = [super init]) {
		_point = point;
		_xyOffset = xyOffset;
	}
	return self;
}

@end
