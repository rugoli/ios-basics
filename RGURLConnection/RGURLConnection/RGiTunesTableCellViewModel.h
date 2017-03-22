//
//  RGiTunesTableCellViewModel.h
//  RGURLConnection
//
//  Created by Roshan Goli on 4/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGiTunesTableCellViewModel : NSObject

- (instancetype)initWithName:(NSString *)name
											author:(NSString *)author;

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *author;

@end
