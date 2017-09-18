//
//  ViewController.m
//  TableViewDataSource
//
//  Created by Roshan Goli on 9/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGTableViewController.h"

#import "RGMockTableViewDataSource.h"

@interface RGTableViewController () <RGMockTableViewDataSourceListener>
@end

@implementation RGTableViewController {
  RGMockTableViewDataSource *_mockDataSource;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
    _mockDataSource = [[RGMockTableViewDataSource alloc] initWithDataSourceListener:self];
	}
	return self;
}

- (void)loadView
{
  [super loadView];
  
  _tableView.dataSource = _mockDataSource;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [_mockDataSource startGeneratingForTableView:_tableView];
}

# pragma mark - RGMockTableViewDataSourceListener methods

- (void)mockDataSourceAddedNewObject
{
  [_tableView reloadData];
}

@end
