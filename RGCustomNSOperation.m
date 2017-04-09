//
//  RGCustomNSOperation.m
//  RGURLConnection
//
//  Created by Roshan Goli on 4/9/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGCustomNSOperation.h"

@implementation RGCustomNSOperation {
	BOOL _isExecuting;
	BOOL _isFinished;
}

# pragma mark - Public methods

- (void)markAsDone
{
	[self _setIsFinished:YES];
	[self setIsExecuting:NO];
}

- (void)setIsExecuting:(BOOL)isExecuting
{
	[self willChangeValueForKey:@"isExecuting"];
	_isExecuting = isExecuting;
	[self didChangeValueForKey:@"isExecuting"];
}

# pragma mark - Private helpers

- (void)_setIsFinished:(BOOL)isFinished
{
	[self willChangeValueForKey:@"isFinished"];
	_isFinished = isFinished;
	[self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isExecuting
{
	return _isExecuting;
}

- (BOOL)isFinished
{
	return _isFinished;
}

@end
