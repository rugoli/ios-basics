//
//  RGStockSearchResultCell.m
//  RGBrokerage
//
//  Created by Roshan Goli on 5/31/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockSearchResultCell.h"

@implementation RGStockSearchResultCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		self.hidden = YES;
		
		[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectCell)]];
		
		_highlightOverlayView.hidden = YES;
	}
	return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	
	_highlightOverlayView.hidden = !highlighted;
}

- (void)didSelectCell
{
	NSLog(@"testing");
}

@end
