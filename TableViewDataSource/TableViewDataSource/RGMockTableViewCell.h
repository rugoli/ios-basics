//
//  RGMockTableViewCell.h
//  TableViewDataSource
//
//  Created by Roshan Goli on 9/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kMockCellReuseID;

@interface RGMockTableViewCell : UITableViewCell

//@property (nonatomic, weak, readwrite) IBOutlet UILabel *counterLabel;

- (instancetype)initWithCounterText:(NSString *)counterText;
- (void)configureWithNewCounter:(NSString *)counterText;

@end
