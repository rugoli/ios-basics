//
//  ViewController.m
//  RGURLConnection
//
//  Created by Roshan Goli on 3/21/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "URLView.h"

@implementation URLView {
	UILabel *_textLabel;
	UIButton *_fetchDataButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		_fetchDataButton = [[UIButton alloc] initWithFrame:CGRectZero];
		[_fetchDataButton setTitle:@"Fetch Data" forState:UIControlStateNormal];
		[_fetchDataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_fetchDataButton addTarget:self action:@selector(tappedFetchDataButton:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_fetchDataButton];
		
		_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_textLabel.text = @"hello";
		[self addSubview:_textLabel];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	CGRect bounds = self.bounds;
	CGFloat x = bounds.size.width / 2.0, y = 100;

	CGSize buttonSize = [_fetchDataButton sizeThatFits:bounds.size];
	_fetchDataButton.frame = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
	_fetchDataButton.center = CGPointMake(x, y);
	y += 30;
	
	_textLabel.frame = CGRectMake(0, 0, 20, 20);
	[_textLabel sizeToFit];
	_textLabel.center = CGPointMake(x, y);
}

- (void)tappedFetchDataButton:(UIButton *)sender
{
	[_delegate URLViewDidTapFetchData:self];
}

@end
