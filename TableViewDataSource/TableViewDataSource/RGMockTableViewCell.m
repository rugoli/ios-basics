//
//  RGMockTableViewCell.m
//  TableViewDataSource
//
//  Created by Roshan Goli on 9/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGMockTableViewCell.h"

NSString *const kMockCellReuseID = @"mock-table-cell";

@implementation RGMockTableViewCell {
  UILabel *_counterLabel;
  NSString *_counterText;
}

- (instancetype)initWithCounterText:(NSString *)counterText
{
  if (self = [super init]) {
    [self _addLabelIfNecessary];
    [self configureWithNewCounter:counterText];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  const CGFloat kSidePadding = 12;
  const CGFloat kTopBottomPadding = 10;
  const CGSize contentSize = self.contentView.bounds.size;
  
  CGSize labelSize = [_counterLabel sizeThatFits:CGSizeMake(contentSize.width - 2*kSidePadding, contentSize.height - 2*kTopBottomPadding)];
  _counterLabel.frame = CGRectMake(kSidePadding, kTopBottomPadding, labelSize.width, labelSize.height);
}

- (void)configureWithNewCounter:(NSString *)counterText
{
  [self _addLabelIfNecessary];
  _counterText = [counterText copy];
  _counterLabel.text = _counterText;
  
  [self setNeedsDisplay];
}

- (void)_addLabelIfNecessary
{
  if (!_counterLabel) {
    _counterLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_counterLabel];
  }
}

@end
