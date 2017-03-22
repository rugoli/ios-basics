//
//  RGiTunesTableCellViewModel.m
//  RGURLConnection
//
//  Created by Roshan Goli on 4/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGiTunesTableCellViewModel.h"

@implementation RGiTunesTableCellViewModel

- (instancetype)initWithName:(NSString *)name
											author:(NSString *)author
{
	if (self = [super init]) {
		_name = name;
		_author = author;
	}
	return self;
}

@end
