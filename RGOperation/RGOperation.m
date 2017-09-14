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

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype _Nonnull )initWithBlock:(void (^_Nonnull)(void))block
{
	if (self = [super init]) {
		_executionBlock = block;
	}
	return self;
}

- (void)start
{
	_executing = YES;
	_executionBlock();
	_executing = NO;
	[self _setIsFinished:YES];
}

- (void)cancel
{
	// no-op
}

- (BOOL)isExecuting
{
	return _executing;
}

- (void)_setIsFinished:(BOOL)isFinished
{
	[self willChangeValueForKey:@"finished"];
	_finished = isFinished;
	[self didChangeValueForKey:@"finished"];
}

- (BOOL)isFinished
{
	return _finished;
}

@end
