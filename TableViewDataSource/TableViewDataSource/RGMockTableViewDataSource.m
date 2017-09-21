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
}

- (instancetype)init
{
  if (self = [super init]) {
    _cellData = [NSMutableArray new];
    _randomCellSubtitle = [NSMutableArray new];
    _secondsElapsed = 0;
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
  [_tableView beginUpdates];
  _secondsElapsed++;
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self _tableInsertionPoint]
                                              inSection:0];
  [_cellData insertObject:@(_secondsElapsed)
                  atIndex:indexPath.row];
  [_randomCellSubtitle insertObject:[self _randomNumber]
                            atIndex:indexPath.row];
  NSLog(@"%lu", _secondsElapsed);
  
  [_tableView insertRowsAtIndexPaths:@[indexPath]
                    withRowAnimation:UITableViewRowAnimationTop];
  [_tableView endUpdates];
}

- (NSInteger)_tableInsertionPoint
{
  if (_cellData.count == 0) {
    return 0;
  }
  return MAX(arc4random_uniform(_cellData.count), 0);
}

@end
