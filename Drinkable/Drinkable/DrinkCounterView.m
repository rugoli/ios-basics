//
//  DrinkCounterView.m
//  Drinkable
//
//  Created by Roshan Goli on 4/12/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "DrinkCounterView.h"

@implementation DrinkCounterView

- (void)drawRect:(CGRect)rect {
	CGFloat startAngle = 3 * M_PI / 4.0, endAngle = M_PI / 4.0;
	UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0)
																											radius:60
																									startAngle:startAngle
																										endAngle:endAngle
																									 clockwise:YES];
	[self.arcColor setStroke];
	path.lineWidth = 60;
	[path stroke];
	
	
	// outline
	if (self.counter > 0) {
		CGFloat outlineArcWidth = 8;
		CGFloat angleDifference = 2 * M_PI - (startAngle - endAngle);
		CGFloat anglePerGlass = angleDifference / 8.0;
		path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0)
																					radius:90 - (outlineArcWidth / 2.0)
																			startAngle:startAngle
																				endAngle:startAngle + fmin(self.counter, 8) * anglePerGlass
																			 clockwise:YES];
		
		[path addArcWithCenter:CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0)
										radius:30 + (outlineArcWidth / 2.0)
								startAngle:startAngle + fmin(8, self.counter) * anglePerGlass
									endAngle:startAngle
								 clockwise:NO];
		
		[path closePath];
		[self.outlineColor setStroke];
		path.lineWidth = outlineArcWidth;
		[path stroke];
	}
}

- (void)setCounter:(int)counter
{
	_counter = fmax(0, fmin(counter, 8));
}

@end
