//
//  RGMockTableViewDataSource.m
//  TableViewDataSource
//
//  Created by Roshan Goli on 9/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGMockTableViewDataSource.h"

#import "RGMockTableViewCell.h"

@implementation RGMockTableViewDataSource {
  NSMutableArray<NSNumber *> *_cellData;
  NSMutableArray<NSString *> *_randomCellSubtitle;
  
  NSInteger _secondsElapsed;
  
  __weak id<RGMockTableViewDataSourceListener> _dataSourceListener;
}

- (instancetype)initWithDataSourceListener:(id<RGMockTableViewDataSourceListener>)dataSourceListener
{
  if (self = [super init]) {
    _cellData = [NSMutableArray new];
    _randomCellSubtitle = [NSMutableArray new];
    _secondsElapsed = 0;
    _dataSourceListener = dataSourceListener;
  }
  return self;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return _cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"prototype-cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] init];
  } else {
    cell.textLabel.text = [self _cellTextFromRow:indexPath];
    cell.detailTextLabel.text = _randomCellSubtitle[indexPath.row];
  }
  
  return cell;
}

- (NSString *)_cellTextFromRow:(NSIndexPath *)indexPath
{
  return [NSString stringWithFormat:@"%@", _cellData[indexPath.row]];
}

- (NSString *)_randomNumber
{
  return [NSString stringWithFormat:@"%u", arc4random_uniform(20)];
}

# pragma mark - Public API

- (void)startGeneratingForTableView:(UITableView *)tableView;
{
  [tableView registerClass:[RGMockTableViewCell class]
    forCellReuseIdentifier:kMockCellReuseID];
  [NSTimer scheduledTimerWithTimeInterval:1.0f
                                   target:self
                                 selector:@selector(_addSecondsElapsedObject)
                                 userInfo:nil
                                  repeats:YES];
}

- (void)_addSecondsElapsedObject
{
  _secondsElapsed++;
  [_cellData addObject:@(_secondsElapsed)];
  [_randomCellSubtitle addObject:[self _randomNumber]];
  NSLog(@"%lu", _secondsElapsed);
  [_dataSourceListener mockDataSourceAddedNewObject];
}

@end
