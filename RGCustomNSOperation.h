//
//  RGCustomNSOperation.h
//  RGURLConnection
//
//  Created by Roshan Goli on 4/9/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RGCustomNSOperation

- (BOOL)isAsynchronous;

@end

@interface RGCustomNSOperation : NSOperation

- (void)setIsExecuting:(BOOL)isExecuting;
- (void)markAsDone;

@end
