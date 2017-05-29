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
#import "RGAnimationWrapper.h"
#import "RGAnimatableSquare.h"

static const CGFloat kMaxAnimatableY = 350;

@interface ViewController () <CAAnimationDelegate, UIGestureRecognizerDelegate>

@property (atomic, readwrite, assign) BOOL isReversing;

@end

@implementation ViewController {
	CGPoint _originalSquarePosition;
	NSArray<RGCornerViewModel *> *_cornerPoints;
	
	CABasicAnimation *_currentAnimation;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[_animateButton setTitle:@"Animate" forState:UIControlStateNormal];
	[_animateButton setTitle:@"Stop animating" forState:UIControlStateSelected];

	_originalSquarePosition = _squareView.layer.position;
	
	CGSize viewSize = self.view.bounds.size;
	_cornerPoints = @[[[RGCornerViewModel alloc] initWithPoint:CGPointMake(0, 0) xyOffset:CGPointMake(1, 1)], // top-left
										[[RGCornerViewModel alloc] initWithPoint:CGPointMake(0, kMaxAnimatableY) xyOffset:CGPointMake(1, -1)], // bottom-left
										[[RGCornerViewModel alloc] initWithPoint:CGPointMake(viewSize.width, 0) xyOffset:CGPointMake(-1, 1)], // top-right
										[[RGCornerViewModel alloc] initWithPoint:CGPointMake(viewSize.width, kMaxAnimatableY) xyOffset:CGPointMake(-1, -1)]]; // bottom-right
	
	UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
																																																	action:@selector(didTapSquare:)];
	gestureRecognizer.minimumPressDuration = 0.10;
	gestureRecognizer.delegate = self;
	[self.view addGestureRecognizer:gestureRecognizer];
}

- (IBAction)tappedAnimateButton:(RGAnimateButton *)button
{
	[_squareView.layer setPosition:_squareView.layer.presentationLayer.position];
	[_squareView.layer removeAllAnimations];
	if (button.isSelected) {
		[self _animateReset];
	} else {
		[self _animateToPoint:[self _getRandomCornerWithinBounds]];
		_isReversing = NO;
	}
	[button setSelected:!button.isSelected];
}

- (void)_animateReset
{
	[_squareView.layer removeAllAnimations];
	[self _animateToPoint:_originalSquarePosition];
	_isReversing = YES;
}

- (void)_animateToPoint:(CGPoint)point
{
	_currentAnimation	= [CABasicAnimation animationWithKeyPath:@"position"];
	[_currentAnimation setFromValue:[NSValue valueWithCGPoint:_squareView.layer.position]];
	[_currentAnimation setToValue:[NSValue valueWithCGPoint:point]];
	[_currentAnimation setDuration:3];
	_currentAnimation.delegate = self;
	
	[_squareView.layer setPosition:point];
	[_squareView.layer addAnimation:_currentAnimation forKey:@"position"];
}

- (CGPoint)_getRandomCornerWithinBounds
{
	RGCornerViewModel *randomCorner = [_cornerPoints objectAtIndex: arc4random_uniform(4)];
	CGPoint basePoint = randomCorner.point;
	return CGPointMake(basePoint.x + randomCorner.xyOffset.x * _squareView.dimension.floatValue / 2.0,
										 basePoint.y + randomCorner.xyOffset.y * _squareView.dimension.floatValue / 2.0);
}

# pragma mark - CAAnimationDelegate methods

- (void)animationDidStop:(CAAnimation *)anim
								finished:(BOOL)flag
{
	if (!flag) {
		return;
	} else if (_isReversing) {
		[self.animateButton setSelected:NO];
	} else {
		[self _animateReset];
	}
}

# pragma mark - Tap gesture action

- (void)didTapSquare:(UIGestureRecognizer *)gestureRecognizer
{
	if ([_squareView.layer.animationKeys count] > 0 && gestureRecognizer.state == UIGestureRecognizerStateBegan) {
		[_squareView.layer setPosition:_squareView.layer.presentationLayer.position];
		[_squareView.layer removeAllAnimations];
	} else if (!CGPointEqualToPoint(_squareView.layer.presentationLayer.position, _originalSquarePosition)
						 && gestureRecognizer.state == UIGestureRecognizerStateEnded) {
		[self _animateToPoint:[_currentAnimation.toValue CGPointValue]];
	}
}

# pragma mark - UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
			 shouldReceiveTouch:(UITouch *)touch
{
	CALayer *touchedLayer = [_squareView.layer.presentationLayer hitTest:[touch locationInView:self.view]];
	if (touchedLayer != nil) {
		return YES;
	}
	return NO;
}

@end
