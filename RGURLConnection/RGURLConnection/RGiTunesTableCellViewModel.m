//
//  RGiTunesTableCellViewModel.m
//  RGURLConnection
//
//  Created by Roshan Goli on 4/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGiTunesTableCellViewModel.h"

@implementation RGiTunesTableCellViewModel

- (instancetype)initWithName:(NSString *)name
											author:(NSString *)author
										imageURL:(NSString *)imageURL
{
	if (self = [super init]) {
		_name = name;
		_author = author;
		_imageURL = [imageURL copy];
	}
	return self;
}

- (void)fetchImageForURL:(RGiTunesTableCellViewModelCallbackBlock)completionBlock
{
  NSError *error;
  NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_imageURL]
                                               options:NSDataReadingUncached
                                                 error:&error];
	if (data == nil) {
		return;
	}
	_image = [[UIImage alloc] initWithData:data];
	
	if (completionBlock) {
		completionBlock(_image);
	}
}

@end
