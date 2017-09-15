//
//  RGOperation.h
//  RGBrokerage
//
//  Created by Roshan Goli on 7/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * _Nonnull const kFinishedPropertyKey;
extern NSString * _Nonnull const kReadyPropertyKey;

@interface RGOperation : NSObject

- (instancetype _Nonnull )initWithBlock:(void (^_Nonnull)(void))block;
- (void)start;
- (void)cancel;

@property (readonly, getter=isExecuting) BOOL executing;
@property (readonly, getter=isFinished) BOOL finished;
@property (readonly, getter=isReady) BOOL ready;


- (void)addDependency:(RGOperation *_Nonnull)op;
- (void)removeDependency:(RGOperation *_Nonnull)op;
@property (readonly, copy) NSArray<RGOperation *> * _Nullable dependencies;

@property (nullable, copy) void (^completionBlock)(void) NS_AVAILABLE(10_6, 4_0);

@end
