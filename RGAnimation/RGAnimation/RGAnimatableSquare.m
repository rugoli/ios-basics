//
//  RGAnimatableSquare.m
//  RGAnimation
//
//  Created by Roshan Goli on 4/16/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGAnimatableSquare.h"

@implementation RGAnimatableSquare

@synthesize squareColor = _squareColor;
@synthesize dimension = _dimension;

- (void)drawRect:(CGRect)rect {
	UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, [self.dimension floatValue], [self.dimension floatValue])];
	[self.squareColor setFill];
	[path fill];
	
	[[UIColor blackColor] setStroke];
	[path stroke];
}

- (UIColor *)squareColor
{
	return _squareColor ?: [UIColor redColor];
}

- (NSNumber *)dimension
{
	return _dimension ?: [NSNumber numberWithFloat:100.0];
}

@end
