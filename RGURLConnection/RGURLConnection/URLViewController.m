//
//  ViewController.m
//  RGURLConnection
//
//  Created by Roshan Goli on 3/21/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "URLViewController.h"
#import "RGiTunesTableCellViewModel.h"
#import "RGTableViewCell.h"
#import "RGTableViewDataSource.h"
#import "URLView.h"

static NSString *const kCellReuseIdentifier = @"itunes_cell";

@interface URLViewController () <UISearchBarDelegate, RGTableViewDataSourceDelegate>
@end

@implementation URLViewController {
	URLView *_myView;
	
	UITableView *_tableView;
	
	RGTableViewDataSource *_dataSource;
}

- (instancetype)init
{
	if (self = [super init]) {
		_dataSource = [[RGTableViewDataSource alloc] initWithReuseIdentifier:kCellReuseIdentifier];
		_dataSource.delegate = self;
		
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero
																							style:UITableViewStylePlain];
		_tableView.dataSource = _dataSource;
		_tableView.delegate = _dataSource;
	}
	return self;
}

- (void)loadView
{
	[super loadView];
	
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
	searchBar.delegate = self;
	
	_myView = [[URLView alloc] initWithSearchBar:searchBar
																		 tableView:_tableView];
	[_tableView registerClass:[RGTableViewCell class]
		 forCellReuseIdentifier:kCellReuseIdentifier];
	self.view = _myView;
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	[_myView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
}

# pragma mark - UISearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar
		textDidChange:(NSString *)searchText
{
	[_dataSource executeNewSearchQuery:[searchText stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
}

# pragma mark - RGTableViewDataSourceDelegate methods

- (void)dataSourceFinishedFetch:(RGTableViewDataSource *)dataSource
{
	[_tableView reloadData];
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

@end

