//
//  RGBrokerageSearchButton.m
//  RGBrokerage
//
//  Created by Roshan Goli on 4/26/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGBrokerageSearchBar.h"

@implementation RGBrokerageSearchBar

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		self.searchBarStyle = UISearchBarStyleMinimal;
		self.barStyle = UIBarStyleBlack;
	}
	return self;
}

@end
