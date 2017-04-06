//
//  ViewController.m
//  RGURLConnection
//
//  Created by Roshan Goli on 3/21/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "URLView.h"

@implementation URLView {
	UISearchBar *_searchBar;
	UITableView *_tableView;
}

- (instancetype)initWithSearchBar:(UISearchBar *)searchBar
												tableView:(UITableView *)tableView
{
	if (self = [super initWithFrame:CGRectZero]) {
		_searchBar = searchBar;
		_searchBar.placeholder = @"Search in iTunes";
		[self addSubview:_searchBar];
		
		_tableView = tableView;
		[self addSubview:_tableView];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	CGFloat y = 0;
	
	[_searchBar setFrame:CGRectZero];
	[_searchBar sizeToFit];
	y += _searchBar.bounds.size.height;
	
	[_tableView setFrame:CGRectMake(0, y, self.bounds.size.width, self.bounds.size.height - y)];
}

@end
