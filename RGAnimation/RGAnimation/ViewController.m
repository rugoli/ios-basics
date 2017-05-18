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

@interface ViewController () <CAAnimationDelegate>
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
}

- (IBAction)tappedAnimateButton:(RGAnimateButton *)button
{
	if (button.isSelected) {
		[self _animateReset];
	} else {
		[self _animateToPoint:[self _getRandomCornerWithinBounds]];
	}
	[button setSelected:!button.isSelected];
}

- (void)_animateReset
{
	[_squareView.layer removeAllAnimations];
	[self _animateToPoint:_originalSquarePosition];
	[_animateButton setSelected:NO];
}

- (void)_animateToPoint:(CGPoint)point
{
	_currentAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
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
	if ([_animateButton isSelected]) {
		[self _animateReset];
	}
}

@end
