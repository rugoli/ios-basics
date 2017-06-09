//
//  RGStockSearchResultCell.m
//  RGBrokerage
//
//  Created by Roshan Goli on 5/31/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockSearchResultCell.h"

#import "RGStockSearchModel.h"

@implementation RGStockSearchResultCell {
	RGStockSearchModel *_stockModel;
}

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

- (void)configureWithStockSearchModel:(RGStockSearchModel *)stockModel
{
	[_companyName setText:stockModel.name];
	[_stockSymbol setText:stockModel.stockSymbol];
	[_stockPrice setText:[NSString stringWithFormat:@"%@", stockModel.price]];
	[_changeInPercent setText:stockModel.changeInPercent];
	
	_stockModel = stockModel;
}

- (void)didSelectCell
{
	[_delegate didSelectSearchResultCell:self withModel:_stockModel];
}

@end
