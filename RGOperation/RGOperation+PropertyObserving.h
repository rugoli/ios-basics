//
//  RGOperation+PropertyObserving.h
//  RGOperationTestApp
//
//  Created by Roshan Goli on 9/13/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//
#import "RGOperation.h"

#import <Foundation/Foundation.h>

@interface RGOperation (PropertyObserving)

- (void)addObserver:(id)observer
						keyPath:(NSString *)keyPath;

- (void)removeObserver:(id)observer
							 keyPath:(NSString *)keyPath;

@end
