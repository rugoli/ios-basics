//
//  RGOperationQueue.m
//
//  Created by Roshan Goli on 7/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGOperationQueue.h"

@implementation RGOperationQueue

- (instancetype _Nonnull )initWithName:(NSString *_Nullable)name
											qualityOfService:(NSQualityOfService)qualityOfService;
{
	if (self = [super init]) {
		_qualityOfService = qualityOfService;
		_name = [name copy];
		_underlyingQueue = dispatch_queue_create([_name.length > 0 ? _name : [[NSUUID UUID] UUIDString] cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
	}
	return self;
}

- (void)addOperationWithBlock:(void (^_Nonnull)(void))block
{
	dispatch_async(_underlyingQueue, block);
}

@end
