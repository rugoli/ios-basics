//
//  ViewController.m
//  RGScrollViews
//
//  Created by Roshan Goli on 4/9/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGScrollViewController.h"
#import "RGScrollView.h"	

@implementation RGScrollViewController {
	RGScrollView *_scrollView;
}

- (void)loadView
{
	[super loadView];
	
	_scrollView = [[RGScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
	[_scrollView addViewWithColor:[UIColor greenColor] height:100];
	[_scrollView addViewWithColor:[UIColor redColor] height:150];
	[_scrollView addViewWithColor:[UIColor blueColor] height:250];
	[_scrollView addViewWithColor:[UIColor greenColor] height:200];
	[_scrollView addViewWithColor:[UIColor redColor] height:150];
	
	self.view = _scrollView;
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	_scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	
}

@end
