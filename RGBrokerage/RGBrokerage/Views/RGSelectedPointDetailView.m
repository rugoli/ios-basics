//
//  RGSelectedPointDetailView.m
//  RGBrokerage
//
//  Created by Roshan Goli on 6/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGSelectedPointDetailView.h"

@implementation RGSelectedPointDetailView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		[_quoteValueLabel setHidden:YES];
	}
	return self;
}

- (void)setHidden:(BOOL)hidden
{
	[super setHidden:hidden];
	[_quoteValueLabel setHidden:hidden];
}

- (void)setLabelColor:(UIColor *)labelColor
{
	[_quoteValueLabel setTextColor:labelColor];
}

- (void)setLabelValue:(NSString *)labelValue
{
	[_quoteValueLabel setText:labelValue];
	[_quoteValueLabel sizeToFit];
}

@end
