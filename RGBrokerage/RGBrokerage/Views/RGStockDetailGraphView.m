//
//  RGStockDetailGraphView.m
//  RGBrokerage
//
//  Created by Roshan Goli on 6/8/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockDetailGraphView.h"

@implementation RGStockDetailGraphView

- (void)drawRect:(CGRect)rect {
	UIBezierPath *path = [UIBezierPath new];
	[path addArcWithCenter:CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0)
									radius:MIN(rect.size.width, rect.size.height)/2.0 - 5.0
							startAngle:0
								endAngle:2 * M_PI
							 clockwise:YES];
	[path setLineWidth:1.0];
	[[UIColor greenColor] setFill];
	[[UIColor redColor] setStroke];
	[path fill];
	[path stroke];
}

@end
