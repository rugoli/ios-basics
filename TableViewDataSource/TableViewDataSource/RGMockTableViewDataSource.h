//
//  RGMockTableViewDataSource.h
//  TableViewDataSource
//
//  Created by Roshan Goli on 9/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RGMockTableViewDataSourceListener

- (void)mockDataSourceAddedNewObject;

@end

@interface RGMockTableViewDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithDataSourceListener:(id<RGMockTableViewDataSourceListener>)dataSourceListener;

- (void)startGeneratingForTableView:(UITableView *)tableView;

@end
