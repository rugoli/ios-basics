//
//  RGOperationQueue.h
//  RGBrokerage
//
//  Created by Roshan Goli on 7/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

@class RGOperation;

#import <Foundation/Foundation.h>

@interface RGOperationQueue : NSObject

- (instancetype _Nonnull )initWithName:(NSString *_Nullable)name
											qualityOfService:(NSQualityOfService)qualityOfService;

- (void)addOperation:(RGOperation *_Nonnull)op;
//- (void)addOperations:(NSArray<NSOperation *> *_Nonnull)ops waitUntilFinished:(BOOL)wait NS_AVAILABLE(10_6, 4_0);

- (void)addOperationWithBlock:(void (^_Nonnull)(void))block NS_AVAILABLE(10_6, 4_0);

//@property (readonly, copy) NSArray<__kindof NSOperation *> * _Nonnull operations;
//@property (readonly) NSUInteger operationCount NS_AVAILABLE(10_6, 4_0);

//@property NSInteger maxConcurrentOperationCount;

//@property (getter=isSuspended) BOOL suspended;

@property (nullable, copy) NSString *name NS_AVAILABLE(10_6, 4_0);

@property NSQualityOfService qualityOfService NS_AVAILABLE(10_10, 8_0);

@property (nullable, retain) dispatch_queue_t underlyingQueue NS_AVAILABLE(10_10, 8_0);

//- (void)cancelAllOperations;

//- (void)waitUntilAllOperationsAreFinished;

//#if FOUNDATION_SWIFT_SDK_EPOCH_AT_LEAST(8)
//@property (class, readonly, strong, nullable) NSOperationQueue *currentQueue NS_AVAILABLE(10_6, 4_0);
//@property (class, readonly, strong) NSOperationQueue * _Nonnull mainQueue NS_AVAILABLE(10_6, 4_0);
//#endif

@end
