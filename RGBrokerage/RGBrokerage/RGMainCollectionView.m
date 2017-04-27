//
//  RGMainCollectionView.m
//  RGBrokerage
//
//  Created by Roshan Goli on 4/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGMainCollectionView.h"

@implementation RGMainCollectionView

- (instancetype)initWithFrame:(CGRect)frame
				 collectionViewLayout:(UICollectionViewLayout *)layout
{
	if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
		self.backgroundColor = [UIColor redColor];
	}
	return self;
}

@end
