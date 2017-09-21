//
//  RGURLDataFetchOperation.m
//  RGURLConnection
//
//  Created by Roshan Goli on 4/9/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGURLDataFetchOperation.h"

@interface RGURLDataFetchOperation () <RGCustomNSOperation>
@end

@implementation RGURLDataFetchOperation {
	NSURLSession *_urlSession;
	NSString *_searchQuery;
	RGDataFetchCallback _callbackBlock;
	Class<RGDataFetchParser> _dataParserClass;
}

- (instancetype)initWithURLSession:(NSURLSession *)session
											 searchQuery:(NSString *)searchQuery
												dataParser:(Class<RGDataFetchParser>)dataParser
										 callbackBlock:(RGDataFetchCallback)callbackBlock
{
	if (self = [super init]) {
		_urlSession = session;
		_searchQuery = [searchQuery copy];
		_callbackBlock = callbackBlock;
		_dataParserClass = dataParser;
	}
	return self;
}

- (void)start
{
	if (self.isCancelled) {
		[self markAsDone];
		return;
	}

	[self setIsExecuting:YES];
	__weak __typeof(self) weakSelf = self;
	NSURLSessionDataTask *downloadTask = [_urlSession dataTaskWithURL:[NSURL URLWithString:_searchQuery]
																									completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
																										if (error || data == nil) {
																											[weakSelf _handleDownloadError:error];
																										}
																										[weakSelf handleDownloadWithData:data
																																						response:response];
																									}];
	[downloadTask resume];
}

- (void)_handleDownloadError:(NSError *)error
{
	NSLog(@"Oh no, an error: %@", error.localizedDescription);
	[self returnResultsAndMarkAsDone:[NSArray new]];
}

- (void)handleDownloadWithData:(NSData *)data
											response:(NSURLResponse *)response
{
	if (self.isCancelled || data == nil) {
		[self markAsDone];
		return;
	}
	NSError *error;
	NSDictionary *const dict = [NSJSONSerialization JSONObjectWithData:data
																														 options:NSJSONReadingMutableContainers
																															 error:&error];
	if (!error) {
		NSArray *parsedResults = [_dataParserClass parseFetchedResults:dict];
		[self returnResultsAndMarkAsDone:parsedResults];
	} else {
		[self _handleDownloadError:error];
	}
}

- (void)returnResultsAndMarkAsDone:(NSArray *)results
{
	if (_callbackBlock) {
		_callbackBlock(results);
		[self markAsDone];
	}
}

# pragma mark - NSOperation Overrides

- (BOOL)isAsynchronous
{
	return YES;
}

@end

