//
//  RGOperation.m
//  RGBrokerage
//
//  Created by Roshan Goli on 7/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGOperation.h"
#import "RGOperation+PropertyObserving.h"

typedef void (^RGExecutionBlock)(void);

NSString *const kFinishedPropertyKey = @"finished";
NSString *const kReadyPropertyKey = @"ready";

@implementation RGOperation {
	NSMutableArray<RGOperation *> *_dependencies;
	RGExecutionBlock _executionBlock;
}

@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize ready = _ready;

- (instancetype _Nonnull )initWithBlock:(void (^_Nonnull)(void))block
{
	if (self = [super init]) {
		_executionBlock = block;
		_dependencies = [NSMutableArray new];
		_ready = YES;
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

- (void)_setIsReady:(BOOL)isReady
{
	[self willChangeValueForKey:kReadyPropertyKey];
	_ready = isReady;
	[self didChangeValueForKey:kReadyPropertyKey];
}

- (BOOL)isReady
{
	return _ready;
}

- (BOOL)_canExecute
{
	return !_executing && !_finished && _dependencies.count == 0;
}

- (BOOL)isExecuting
{
	return _executing;
}

- (NSArray<RGOperation *> *)dependencies
{
	return [_dependencies copy];
}

- (void)addDependency:(RGOperation *_Nonnull)op
{
	[op addObserver:self
					keyPath:kFinishedPropertyKey];
	[_dependencies addObject:op];
	[self _setIsReady:NO];
}

- (void)removeDependency:(RGOperation *_Nonnull)op
{
	[op removeObserver:self
						 keyPath:kFinishedPropertyKey];
	[_dependencies removeObject:op];
	if ([self _canExecute]) {
		[self _setIsReady:YES];
	}
}

- (void)_setIsFinished:(BOOL)isFinished
{
	[self willChangeValueForKey:kFinishedPropertyKey];
	_finished = isFinished;
	[self didChangeValueForKey:kFinishedPropertyKey];
}

- (BOOL)isFinished
{
	return _finished;
}

# pragma mark - Operation notification observer

- (void)observeValueForKeyPath:(NSString *)keyPath
											ofObject:(id)object
												change:(NSDictionary<NSKeyValueChangeKey,id> *)change
											 context:(void *)context
{
	if ([object isKindOfClass:[RGOperation class]]
			&& [change[NSKeyValueChangeNewKey] isEqual:@YES]) {
		[self removeDependency:(RGOperation *)object];
	}
}

@end
