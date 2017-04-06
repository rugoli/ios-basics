//
//  RGTableViewDataSource.h
//  RGURLConnection
//
//  Created by Roshan Goli on 4/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RGTableViewDataSourceDelegate;

@interface RGTableViewDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)executeSearchQuery:(NSString *)query;

@property (nonatomic, weak, readwrite) id<RGTableViewDataSourceDelegate> delegate;

@end

@protocol RGTableViewDataSourceDelegate

- (void)dataSourceFinishedFetch:(RGTableViewDataSource *)dataSource;

@end
