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
		[_quoteNameLabel setHidden:YES];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	CGRect bounds = self.bounds;
	
	[_quoteNameLabel sizeToFit];
	[_quoteNameLabel setCenter:CGPointMake(bounds.size.width / 2.0, 10)];
	
	[_quoteValueLabel sizeToFit];
	[_quoteValueLabel setCenter:CGPointMake(bounds.size.width / 2.0, bounds.size.height - 10 - _quoteValueLabel.frame.size.height / 2.0)];

}

- (void)setHidden:(BOOL)hidden
{
	[super setHidden:hidden];
	[_quoteValueLabel setHidden:hidden];
	[_quoteNameLabel setHidden:hidden];
}

- (void)setQuoteLabelColor:(UIColor *)labelColor
{
	[_quoteValueLabel setTextColor:labelColor];
}

- (void)setQuoteLabelValue:(NSString *)labelValue
{
	SetLabelValueAndResize(_quoteValueLabel, labelValue);
}

- (void)setQuoteNameValue:(NSString *)labelValue
{
	SetLabelValueAndResize(_quoteNameLabel, labelValue);
}

- (void)setQuoteNameColor:(UIColor *)labelColor
{
	[_quoteNameLabel setTextColor:labelColor];
}

static void SetLabelValueAndResize(UILabel *label, NSString *newValue)
{
	[label setText:newValue];
	[label sizeToFit];
}

@end
