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

- (void)configureWithNewViewModel:(RGiTunesTableCellViewModel *)viewModel;
@end

@implementation RGTableViewCell {
	RGiTunesTableCellViewModel *_viewModel;
	RGTableViewCellView *_contentView;
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
	[_contentView removeFromSuperview];

	_contentView = [[RGTableViewCellView alloc] initWithFrame:self.contentView.bounds
																									viewModel:viewModel];
	
	[self.contentView addSubview:_contentView];
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
			[self _downloadAndDisplayImageForViewModel:_viewModel];
		} else {
			[self _setImageViewWithImage:viewModel.image];
		}
	}
	return self;
}

- (void)configureWithNewViewModel:(RGiTunesTableCellViewModel *)viewModel
{
	_authorLabel.text = _viewModel.author;
	_titleLabel.text = _viewModel.name;
	[self _downloadAndDisplayImageForViewModel:viewModel];
	
	[self setNeedsLayout];
}

- (void)_downloadAndDisplayImageForViewModel:(RGiTunesTableCellViewModel *)viewModel
{
	__weak typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
		[viewModel fetchImageForURL:^(UIImage *image) {
			dispatch_sync(dispatch_get_main_queue(), ^{
				[weakSelf _setImageViewWithImage:image];
			});
		}];
	});
}

- (void)_setImageViewWithImage:(UIImage *)image
{
	__weak __typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		__strong __typeof(self) strongSelf = weakSelf;
		if (strongSelf && image) {
			if (strongSelf->_imageView) {
				strongSelf->_imageView.image = image;
			} else {
				strongSelf->_imageView = [[UIImageView alloc] initWithImage:image];
				[strongSelf addSubview:strongSelf->_imageView];
			}
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
