//
//  RGiTunesTableCellViewModel.h
//  RGURLConnection
//
//  Created by Roshan Goli on 4/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface RGiTunesTableCellViewModel : NSObject

typedef void (^RGiTunesTableCellViewModelCallbackBlock)(UIImage *image);

- (instancetype)initWithName:(NSString *)name
											author:(NSString *)author
										imageURL:(NSString *)imageURL;

- (void)fetchImageForURL:(RGiTunesTableCellViewModelCallbackBlock)completionBlock;

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *author;
@property (nonatomic, readonly, copy) NSString *imageURL;
@property (nonatomic, readonly, strong) UIImage *image;

@end
