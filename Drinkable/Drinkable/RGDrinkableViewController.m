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
	self.counterView.counter++;
	[self.counterView setNeedsDisplay];
}
- (IBAction)tappedMinusButton:(PushButtonView *)sender
{
	self.counterView.counter--;
	[self.counterView setNeedsDisplay];
}



- (void)loadView
{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
}

@end
