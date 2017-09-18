//
//  RGMockTableViewDataSource.h
//  TableViewDataSource
//
//  Created by Roshan Goli on 9/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RGMockTableViewDataSource : NSObject <UITableViewDataSource>

- (void)startGenerating;

@end
