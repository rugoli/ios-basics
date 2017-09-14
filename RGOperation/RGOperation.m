//
//  RGOperation.m
//  RGBrokerage
//
//  Created by Roshan Goli on 7/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGOperation.h"
#import "RGOperation+PropertyObserving.h"

@interface RGOperation ()

@property (nonatomic, copy, nonnull) void (^executionBlock)(void);

@end

@implementation RGOperation {
	NSMutableArray<RGOperation *> *_dependencies;
}

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype _Nonnull )initWithBlock:(void (^_Nonnull)(void))block
{
	if (self = [super init]) {
		_executionBlock = block;
		_dependencies = [NSMutableArray new];
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

- (BOOL)canExecute
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
					keyPath:@"finished"];
	[_dependencies addObject:op];
}

- (void)removeDependency:(RGOperation *_Nonnull)op
{
	[op removeObserver:self
						 keyPath:@"finished"];
	[_dependencies removeObject:op];
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
