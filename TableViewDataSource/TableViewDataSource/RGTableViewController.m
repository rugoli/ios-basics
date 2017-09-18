//
//  ViewController.m
//  TableViewDataSource
//
//  Created by Roshan Goli on 9/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGTableViewController.h"

#import "RGMockTableViewDataSource.h"

@implementation RGTableViewController {
	UITableView *_tableView;
  RGMockTableViewDataSource *_mockDataSource;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
    _mockDataSource = [[RGMockTableViewDataSource alloc] init];
	}
	return self;
}

- (void)loadView
{
  [super loadView];
  
  _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                            style:UITableViewStylePlain];
  _tableView.dataSource = _mockDataSource;
  
  [self.view addSubview:_tableView];
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  
  _tableView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [_mockDataSource startGenerating];
}

@end
