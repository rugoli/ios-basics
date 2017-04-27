//
//  ViewController.m
//  RGBrokerage
//
//  Created by Roshan Goli on 4/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "ViewController.h"

#import "RGMainCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController {
	RGMainCollectionView *_mainView;
}

- (void)loadView
{
	[super loadView];
	_mainView = [[RGMainCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewLayout alloc] init]];
	
	self.view = _mainView;
}

@end
