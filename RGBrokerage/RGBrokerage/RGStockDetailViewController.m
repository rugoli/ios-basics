//
//  RGStockDetailViewController.m
//  RGBrokerage
//
//  Created by Roshan Goli on 6/6/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGStockDetailViewController.h"
#import "RGStockSearchModel.h"

@implementation RGStockDetailViewController {
	RGStockSearchModel *_stockModel;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
	[self.navigationController.navigationBar setTintColor:[UIColor greenColor]];
}

- (void)setStockModel:(RGStockSearchModel *)stockModel
{
	_stockModel = stockModel;
	
	_navigationItem.title = stockModel.stockSymbol;
}

- (IBAction)didTapCancel:(id)sender
{
	[self dismissViewControllerAnimated:self completion:nil];
}

@end
