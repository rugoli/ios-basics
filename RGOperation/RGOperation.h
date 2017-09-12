//
//  RGOperation.h
//  RGBrokerage
//
//  Created by Roshan Goli on 7/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGOperation : NSObject

- (instancetype _Nonnull )initWithBlock:(void (^_Nonnull)(void))block;
- (void)start;
- (void)cancel;

@property (nullable, copy) void (^completionBlock)(void) NS_AVAILABLE(10_6, 4_0);

@end
