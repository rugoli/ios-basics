//
//  RGOperation+PropertyObserving.m
//  RGOperationTestApp
//
//  Created by Roshan Goli on 9/13/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGOperation+PropertyObserving.h"

@implementation RGOperation (PropertyObserving)

- (void)addObserver:(id)observer
						keyPath:(NSString *)keyPath
{
	[self addObserver:observer
				 forKeyPath:keyPath
						options:NSKeyValueObservingOptionNew
						context:NULL];
}

- (void)removeObserver:(id)observer
							 keyPath:(NSString *)keyPath
{
	[self removeObserver:observer
						forKeyPath:keyPath];
}

@end
