//
//  ViewController.m
//  RGURLConnection
//
//  Created by Roshan Goli on 3/21/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "URLViewController.h"
#import "URLView.h"

@interface URLViewController () <URLViewDelegate, NSURLSessionDelegate>
@end

@implementation URLViewController

- (void)loadView
{
	[super loadView];
	URLView *myView = [[URLView alloc] initWithFrame:CGRectZero];
	[myView setBackgroundColor:[UIColor redColor]];
	myView.delegate = self;

	self.view = myView;
}

# pragma mark - URLViewDelegate methods

- (void)URLViewDidTapFetchData:(URLView *)urlView
{
	NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/search?term=apple&media=software"];

	NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
																													 delegate:self
																											delegateQueue:[NSOperationQueue mainQueue]];
	__typeof (self) weakSelf = self;
	NSURLSessionDataTask *downloadTask = [urlSession dataTaskWithURL:url
																								 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
																									 if (error) {
																										 NSLog(@"Oh no, an error: %@", error.description);
																										 return;
																									 }
																									 [weakSelf handleDownloadWithData:data response:response];
																								 }];
	[downloadTask resume];
}

- (void)handleDownloadWithData:(NSData *)data
											response:(NSURLResponse *)response
{
	NSLog(@"data");
}

# pragma mark - NSURLSessionDelegate methods

- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
	NSLog(@"testing");
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error
{
	NSLog(@"test");
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
	NSLog(@"test");
}

@end

