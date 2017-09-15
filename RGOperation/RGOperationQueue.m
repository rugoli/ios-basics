//
//  RGOperationQueue.m
//
//  Created by Roshan Goli on 7/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGOperationQueue.h"

#import "RGOperation+PropertyObserving.h"
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

// when we add a new operation, if it is ready to execute,
// exeucte it. Otherwise, observe ready property
- (void)addOperation:(RGOperation *)op
{
	[_operationQueue addObject:op];
	if ([op isReady]) {
		[self _executeOperation:op];
	} else {
		[op addObserver:self
						keyPath:kReadyPropertyKey];
	}
}

# pragma mark - Private methods

- (void)_executeOperation:(RGOperation *)operation
{
	[operation addObserver:self
								 keyPath:kFinishedPropertyKey];

	dispatch_async(_underlyingQueue, ^{
		[operation start];
	});
}

# pragma mark - Operation notification observer

- (void)observeValueForKeyPath:(NSString *)keyPath
											ofObject:(id)object
												change:(NSDictionary<NSKeyValueChangeKey,id> *)change
											 context:(void *)context
{
	if ([keyPath isEqualToString:kFinishedPropertyKey]
			&& [object isKindOfClass:[RGOperation class]]
			&& [change[NSKeyValueChangeNewKey] isEqual:@YES]) {
		[(RGOperation *)object removeObserver:self
																	keyPath:kFinishedPropertyKey];
		[_operationQueue removeObject:(RGOperation *)object];
	} else if ([keyPath isEqualToString:kReadyPropertyKey]
						 && [object isKindOfClass:[RGOperation class]]
						 && [change[NSKeyValueChangeNewKey] isEqual:@YES]) {
		[(RGOperation *)object removeObserver:self
																	keyPath:kReadyPropertyKey];
		[self _executeOperation:(RGOperation *)object];
	}
}

@end
