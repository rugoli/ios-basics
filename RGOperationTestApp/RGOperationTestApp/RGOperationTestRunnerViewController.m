//
//  ViewController.m
//  RGOperationTestApp
//
//  Created by Roshan Goli on 9/11/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGOperationTestRunnerViewController.h"

#import "RGOperationQueue.h"
#import "RGOperation.h"

@implementation RGOperationTestRunnerViewController {
	RGOperationQueue *_operationQueue;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		_operationQueue = [[RGOperationQueue alloc] initWithName:@"myQueue"
																						qualityOfService:NSQualityOfServiceUserInitiated];
	}
	return self;
}

- (IBAction)tappedRunTest:(id)sender
{
	[_operationQueue addOperation:[self _operationWithLog:@"A"]];
	[_operationQueue addOperation:[self _operationWithLog:@"B"]];
}

- (RGOperation *)_operationWithLog:(NSString *)logValue
{
	return [[RGOperation alloc] initWithBlock:^{
		NSLog(@"%@", logValue);
	}];
}

@end
