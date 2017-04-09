//
//  RGTableViewCell.m
//  RGURLConnection
//
//  Created by Roshan Goli on 4/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGTableViewCell.h"
#import "RGiTunesTableCellViewModel.h"

@interface RGTableViewCellView : UIView
- (instancetype)initWithFrame:(CGRect)frame
										viewModel:(RGiTunesTableCellViewModel *)viewModel;
@end

@implementation RGTableViewCell {
	RGiTunesTableCellViewModel *_viewModel;
}

+ (instancetype)newWithViewModel:(RGiTunesTableCellViewModel *)viewModel
{
	RGTableViewCell *cell = [[RGTableViewCell alloc] init];
	if (cell) {
		[cell configureWithNewViewModel:viewModel];
		cell->_viewModel = viewModel;
	}
	return cell;
}

- (void)configureWithNewViewModel:(RGiTunesTableCellViewModel *)viewModel
{
	_viewModel = viewModel;
	for (UIView *subviews in [self.contentView subviews]) {
		[subviews removeFromSuperview];
	}
	[self.contentView addSubview:[[RGTableViewCellView alloc] initWithFrame:self.contentView.bounds
																																viewModel:viewModel]];
}

@end

@implementation RGTableViewCellView {
	RGiTunesTableCellViewModel *_viewModel;
	UILabel *_titleLabel;
	UILabel *_authorLabel;
	UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
										viewModel:(RGiTunesTableCellViewModel *)viewModel
{
	if (self = [super initWithFrame:frame]) {
		_viewModel = viewModel;
		
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_titleLabel.text = _viewModel.name;
		_titleLabel.font = [UIFont systemFontOfSize:14];
		[self addSubview:_titleLabel];
		
		_authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_authorLabel.text = _viewModel.author;
		_authorLabel.font = [UIFont systemFontOfSize:12];
		[self addSubview:_authorLabel];
		
		if (_viewModel.image == nil && _viewModel.imageURL.length > 0) {
			__weak __typeof(self) weakSelf = self;
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
				[viewModel fetchImageForURL:^(UIImage *image) {
					[weakSelf _addImageViewWithImage:image];
				}];
			});
		} else {
			[self _addImageViewWithImage:viewModel.image];
		}
	}
	return self;
}

- (void)_addImageViewWithImage:(UIImage *)image
{
	__weak __typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		__strong __typeof(self) strongSelf = weakSelf;
		if (strongSelf && image) {
			strongSelf->_imageView = [[UIImageView alloc] initWithImage:image];
			[strongSelf addSubview:strongSelf->_imageView];
			[strongSelf setNeedsLayout];
		}
	});
}


- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat kSidePadding = 10, kTopBottomPadding = 5;
	CGFloat x = kSidePadding, y = kTopBottomPadding;
	
	if (_imageView)  {
		[_imageView setFrame:CGRectMake(x, y, _imageView.bounds.size.width, _imageView.bounds.size.height)];
		x += _imageView.bounds.size.width + 10;
	}
	
	CGSize titleSize = [_titleLabel sizeThatFits:CGSizeMake(self.bounds.size.width - kSidePadding - x, self.bounds.size.height)];
	[_titleLabel setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
	
	CGSize authorSize = [_authorLabel sizeThatFits:CGSizeMake(self.bounds.size.width - kSidePadding - x, self.bounds.size.height)];
	[_authorLabel setFrame:CGRectMake(x, self.bounds.size.height - authorSize.height - kTopBottomPadding, authorSize.width, authorSize.height)];
}

@end
