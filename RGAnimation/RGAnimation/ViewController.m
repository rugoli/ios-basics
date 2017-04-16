//
//  ViewController.m
//  RGAnimation
//
//  Created by Roshan Goli on 4/16/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "ViewController.h"

#import "RGAnimatableSquare.h"
#import <QuartzCore/QuartzCore.h>
#import "RGAnimateButton.h"
#import "RGCornerViewModel.h"

static const CGFloat kMaxAnimatableY = 350;

@implementation ViewController {
	CGRect _originalFrame;
	NSArray<RGCornerViewModel *> *_cornerPoints;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[_animateButton setTitle:@"Animate" forState:UIControlStateNormal];
	[_animateButton setTitle:@"Stop animating" forState:UIControlStateSelected];

	_originalFrame = _squareView.frame;
	
	CGSize viewSize = self.view.bounds.size;
	_cornerPoints = @[[[RGCornerViewModel alloc] initWithPoint:CGPointMake(0, 0) xyOffset:CGPointMake(1, 1)], // top-left
										[[RGCornerViewModel alloc] initWithPoint:CGPointMake(0, kMaxAnimatableY) xyOffset:CGPointMake(1, -1)], // bottom-left
										[[RGCornerViewModel alloc] initWithPoint:CGPointMake(viewSize.width, 0) xyOffset:CGPointMake(-1, 1)], // top-right
										[[RGCornerViewModel alloc] initWithPoint:CGPointMake(viewSize.width, kMaxAnimatableY) xyOffset:CGPointMake(-1, -1)]]; // bottom-right
}

- (IBAction)tappedAnimateButton:(RGAnimateButton *)button
{
	if (button.isSelected) {
		[self _animateReset];
	} else {
		[self _animateSquareInRandomDirection];
	}
	[button setSelected:!button.isSelected];
}

- (void)_turnOffAnimationAndResetPosition
{
	_squareView.frame = _originalFrame;
	[_animateButton setSelected:NO];
}

- (void)_animateReset
{
	[_squareView.layer removeAllAnimations];
//	[self _animateToPoint:_originalFrame.origin
//						 completion:nil];
}

- (void)_animateSquareInRandomDirection
{
	__weak __typeof(self) weakSelf = self;
	[self _animateToPoint:[self _getRandomCornerWithinBounds]
						 completion:^(BOOL finished) {
							 [weakSelf _turnOffAnimationAndResetPosition];
						 }];
}

- (void)_animateToPoint:(CGPoint)point
						 completion:(void (^ __nullable)(BOOL finished))completion
{
	__weak __typeof(self) weakSelf = self;
	[UIView animateWithDuration:3
												delay:0
											options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews
									 animations:^{
										 __strong __typeof(self) strongSelf = weakSelf;
										 if (strongSelf) {
											 strongSelf->_squareView.center = point;
										 }
									 }
									 completion:completion];
}

- (CGPoint)_getRandomCornerWithinBounds
{
	RGCornerViewModel *randomCorner = [_cornerPoints objectAtIndex: arc4random_uniform(4)];
	CGPoint basePoint = randomCorner.point;
	return CGPointMake(basePoint.x + randomCorner.xyOffset.x * _squareView.dimension.floatValue / 2.0,
										 basePoint.y + randomCorner.xyOffset.y * _squareView.dimension.floatValue / 2.0);
}

@end
