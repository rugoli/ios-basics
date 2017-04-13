//
//  RGScrollView.m
//  RGScrollViews
//
//  Created by Roshan Goli on 4/9/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <ComponentKit/CKComponent.h>
#import <ComponentKit/CKComponentHostingView.h>
#import <ComponentKit/CKComponentFlexibleSizeRangeProvider.h>

#import "RGScrollView.h"

@interface RGScrollView () <CKComponentProvider>
@end

@implementation RGScrollView {
	NSMutableArray<UIView *> *_views;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		_views = [NSMutableArray new];
	}
	return self;
}

- (void)addViewWithColor:(UIColor *)viewColor
									height:(CGFloat)viewHeight
{
	CKComponentHostingView *hostingView = [[CKComponentHostingView alloc] initWithComponentProvider:[self class]
																																				 sizeRangeProvider:[CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleHeight]];
	NSDictionary *const viewModel = @{@"color" : viewColor, @"height" : @(viewHeight)};
	[hostingView updateModel:viewModel mode:CKUpdateModeAsynchronous];
	
	[_views addObject:hostingView];
	[self addSubview:hostingView];

	[self setNeedsLayout];
	[self setNeedsDisplay];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	CGFloat y = 0;
	CGSize bounds = self.bounds.size;
	for (UIView *view in _views) {
		CGSize viewSize = [view sizeThatFits:CGSizeMake(bounds.width, bounds.height)];
		[view setFrame:CGRectMake(0, y, viewSize.width, viewSize.height)];
		y+= viewSize.height;
	}
}

+ (CKComponent *)componentForModel:(id<NSObject>)model
													 context:(id<NSObject>)context
{
	NSDictionary *const viewModel = (NSDictionary *)model;
	return
	[CKComponent
	 newWithView:{
		 [UIView class],
		 {
			 {@selector(setBackgroundColor:), viewModel[@"color"]},
			 {@selector(setUserInteractionEnabled:), @NO},
		 }
	 }
	 size:{
		 .height = [viewModel[@"height"] floatValue],
		 .width = CKRelativeDimension::Percent(1),
	 }];
}

@end
