//
//  RGDataFetchOperation.m
//  RGURLConnection
//
//  Created by Roshan Goli on 4/9/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGDataFetchOperation.h"

#import "RGiTunesTableCellViewModel.h"

@interface RGDataFetchOperation () <RGCustomNSOperation>
@end

@implementation RGDataFetchOperation {
	NSURLSession *_urlSession;
	NSString *_searchQuery;
	RGDataFetchCallback _callbackBlock;
	
	NSMutableArray<RGiTunesTableCellViewModel *> *_results;
}

- (instancetype)initWithURLSession:(NSURLSession *)session
											 searchQuery:(NSString *)searchQuery
										 callbackBlock:(RGDataFetchCallback)callbackBlock;
{
	if (self = [super init]) {
		_urlSession = session;
		_searchQuery = [searchQuery copy];
		_callbackBlock = callbackBlock;
		
		_results = [NSMutableArray new];
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
																										if (error) {
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
	if (self.isCancelled) {
		[self  markAsDone];
		return;
	}
	NSError *error;
	NSDictionary *const dict = [NSJSONSerialization JSONObjectWithData:data
																														 options:NSJSONReadingMutableContainers
																															 error:&error];
	if (!error) {
		NSArray *const results = (NSArray *)[dict objectForKey:@"results"];
		[self generateViewModelsFromResults:results];
	} else {
		[self _handleDownloadError:error];
	}
}

- (void)generateViewModelsFromResults:(NSArray *)results
{
	if (self.isCancelled) {
		[self markAsDone];
		return;
	}
	
	__weak __typeof(self) weakSelf = self;
	[results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		__strong __typeof(self) strongSelf = weakSelf;
		if (!strongSelf) {
			return;
		}
		NSDictionary *result = (NSDictionary *)obj;
		if (![result isKindOfClass:[NSDictionary class]]) {
			return;
		}
		[strongSelf->_results addObject:[[RGiTunesTableCellViewModel alloc] initWithName:result[@"trackName"]
																																							author:result[@"artistName"]
																																						imageURL:result[@"artworkUrl30"]]];
	}];
	
	[self returnResultsAndMarkAsDone:_results];
}

- (void)returnResultsAndMarkAsDone:(NSArray<RGiTunesTableCellViewModel *> *)results
{
	if (_callbackBlock) {
		_callbackBlock(_results, self);
		[self markAsDone];
	}
}

# pragma mark - NSOperation Overrides

- (BOOL)isAsynchronous
{
	return YES;
}

@end

