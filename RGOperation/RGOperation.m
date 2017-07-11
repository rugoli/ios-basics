//
//  RGOperation.m
//  RGBrokerage
//
//  Created by Roshan Goli on 7/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGOperation.h"

@interface RGOperation ()

@property (nonatomic, copy, nonnull) void (^executionBlock)(void);

@end

@implementation RGOperation

- (instancetype _Nonnull )initWithBlock:(void (^_Nonnull)(void))block
{
	if (self = [super init]) {
		_executionBlock = block;
	}
	return self;
}

@end
