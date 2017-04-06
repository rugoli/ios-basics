//
//  RGTableViewCell.h
//  RGURLConnection
//
//  Created by Roshan Goli on 4/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGiTunesTableCellViewModel;

@interface RGTableViewCell : UITableViewCell

+ (instancetype)newWithViewModel:(RGiTunesTableCellViewModel *)viewModel;
- (void)configureWithNewViewModel:(RGiTunesTableCellViewModel *)viewModel;

@end
