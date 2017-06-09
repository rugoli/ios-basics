//
//  RGMainCollectionView.m
//  RGBrokerage
//
//  Created by Roshan Goli on 4/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGMainCollectionView.h"

@implementation RGMainCollectionView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		self.collectionViewLayout = [[UICollectionViewLayout alloc] init];
	}
	return self;
}

@end
