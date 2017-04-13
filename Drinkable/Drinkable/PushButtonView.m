//
//  PushButtonView.m
//  Drinkable
//
//  Created by Roshan Goli on 4/12/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "PushButtonView.h"

@implementation PushButtonView

- (void)drawRect:(CGRect)rect {
	UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
	[self.buttonColor setFill];
	[path fill];
	
	CGFloat lineWidth = 0.6 * rect.size.width;
	[path moveToPoint:CGPointMake((rect.size.width - lineWidth) / 2.0, rect.size.height / 2.0)];
	[path addLineToPoint:CGPointMake((rect.size.width + lineWidth) / 2.0, rect.size.height / 2.0)];
	
	if (self.isAddButton) {
		[path moveToPoint:CGPointMake(rect.size.width / 2.0, (rect.size.height - lineWidth) / 2.0)];
		[path addLineToPoint:CGPointMake(rect.size.width / 2.0, (rect.size.height + lineWidth) / 2.0)];
	}
	
	path.lineWidth = 3;
	[[UIColor whiteColor] setStroke];
	[path stroke];
}

@end
