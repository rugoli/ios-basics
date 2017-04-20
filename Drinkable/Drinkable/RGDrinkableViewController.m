//
//  ViewController.m
//  Drinkable
//
//  Created by Roshan Goli on 4/12/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGDrinkableViewController.h"
#import "PushButtonView.h"
#import "DrinkCounterView.h"

@implementation RGDrinkableViewController


- (IBAction)tappedAddButton:(PushButtonView *)sender
{
	[self _updateCounter:1];
}
- (IBAction)tappedMinusButton:(PushButtonView *)sender
{
	[self _updateCounter:-1];
}

- (void)_updateCounter:(int)counterChange
{
	self.counterView.counter += counterChange;
	self.counterLabel.text = [NSString stringWithFormat:@"%d", self.counterView.counter];
	[self.counterView setNeedsDisplay];
	[self.counterLabel setNeedsDisplay];
}

- (void)loadView
{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
}

@end
