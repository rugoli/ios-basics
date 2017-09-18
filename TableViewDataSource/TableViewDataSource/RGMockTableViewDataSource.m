//
//  RGMockTableViewDataSource.m
//  TableViewDataSource
//
//  Created by Roshan Goli on 9/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGMockTableViewDataSource.h"

@implementation RGMockTableViewDataSource {
  NSMutableArray *_cellData;
  
  NSInteger _secondsElapsed;
}

- (instancetype)init
{
  if (self = [super init]) {
    _cellData = [NSMutableArray new];
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
  return nil;
}

# pragma mark - Public API

- (void)startGenerating
{
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
  NSLog(@"%lu", _secondsElapsed);
}

@end
