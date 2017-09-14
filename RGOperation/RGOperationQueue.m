//
//  RGOperationQueue.m
//
//  Created by Roshan Goli on 7/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGOperationQueue.h"

#import "RGOperation.h"

@implementation RGOperationQueue {
	NSMutableArray<RGOperation *> *_operationQueue;
}

- (instancetype _Nonnull )initWithName:(NSString *_Nullable)name
											qualityOfService:(NSQualityOfService)qualityOfService;
{
	if (self = [super init]) {
		_qualityOfService = qualityOfService;
		_name = [name copy];
		_underlyingQueue = dispatch_queue_create([_name.length > 0 ? _name : [[NSUUID UUID] UUIDString] cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
		_operationQueue = [NSMutableArray new];
	}
	return self;
}

- (void)addOperationWithBlock:(void (^_Nonnull)(void))block
{
	RGOperation *newOperation = [[RGOperation alloc] initWithBlock:block];
	[self addOperation:newOperation];
}

- (void)addOperation:(RGOperation *)op
{
	[_operationQueue addObject:op];
	[self _executeOperation:op];
}

# pragma mark - Private methods

- (void)_executeOperation:(RGOperation *)operation
{
	[self _addObserverForOperation:operation
												 keyPath:@"finished"];
	dispatch_async(_underlyingQueue, ^{
		[operation start];
	});
}

- (void)_executeNextOperation
{
	if ([_operationQueue count] > 0) {
		for (RGOperation *op in _operationQueue) {
			if (![op isExecuting] && ![op isFinished]) {
				[self _executeOperation:op];
				break;
			}
		}
	}
}

# pragma mark - Operation notification observer

- (void)observeValueForKeyPath:(NSString *)keyPath
											ofObject:(id)object
												change:(NSDictionary<NSKeyValueChangeKey,id> *)change
											 context:(void *)context
{
	if ([object isKindOfClass:[RGOperation class]]
			&& [change[NSKeyValueChangeNewKey] isEqual:@YES]) {
		[self _removeObserverForOperation:(RGOperation *)object
															keyPath:@"finished"];
		[_operationQueue removeObject:(RGOperation *)object];
		[self _executeNextOperation];
	}
}

- (void)_addObserverForOperation:(RGOperation *)operation
												 keyPath:(NSString *)keyPath
{
	[operation addObserver:self
							forKeyPath:keyPath
								 options:NSKeyValueObservingOptionNew
								 context:NULL];
}

- (void)_removeObserverForOperation:(RGOperation *)operation
														keyPath:(NSString *)keyPath
{
	[operation removeObserver:self
								 forKeyPath:keyPath];
}

@end
