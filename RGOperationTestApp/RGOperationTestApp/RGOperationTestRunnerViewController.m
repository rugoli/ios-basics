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

- (IBAction)tappedSerialTest:(id)sender
{
	[_operationQueue addOperation:[self _operationWithLog:@"A"]];
	[_operationQueue addOperation:[self _operationWithLog:@"B"]];
}

- (IBAction)tappedRunDepedencyTest:(id)sender
{
	RGOperation *operationA = [self _operationWithLog:@"A"];
	RGOperation *operationB = [self _operationWithLog:@"B"];
	RGOperation *operationC = [self _operationWithLog:@"C"];
	
	[operationB addDependency:operationC];
	[operationA addDependency:operationB];
	
	[_operationQueue addOperation:operationA];
	[_operationQueue addOperation:operationB];
	[_operationQueue addOperation:operationC];
}

- (RGOperation *)_operationWithLog:(NSString *)logValue
{
	return [[RGOperation alloc] initWithBlock:^{
		NSLog(@"%@", logValue);
	}];
}

@end
