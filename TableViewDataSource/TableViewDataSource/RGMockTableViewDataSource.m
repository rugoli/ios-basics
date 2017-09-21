//
//  RGMockTableViewDataSource.m
//  TableViewDataSource
//
//  Created by Roshan Goli on 9/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "RGMockTableViewDataSource.h"

#import "RGiTunesDataParser.h"
#import "RGURLDataFetcher.h"
#import "RGiTunesTableCellViewModel.h"
#import "RGMockTableViewCell.h"

@interface RGMockTableViewDataSource () <RGDataFetcherDelegate>
@end

@implementation RGMockTableViewDataSource {
  NSMutableArray<RGiTunesTableCellViewModel *> *_songs;
  NSArray<NSString *> *_sampleSearchTerms;
  
  RGURLDataFetcher *_urlDataFetcher;
}

- (instancetype)init
{
  if (self = [super init]) {
    _songs = [NSMutableArray new];
    _sampleSearchTerms = @[@"Hello", @"Love", @"Fight", @"Beatles", @"Hate", @"Broken", @"Time", @"Never", @"Swift", @"Adele", @"Whatever", @"Rolling Stones", @"My", @"Dragon"];
    
    _urlDataFetcher = [[RGURLDataFetcher alloc] initWithQueueName:@"data-fetcher"
                                                       dataParser:[RGiTunesDataParser class]];
    _urlDataFetcher.delegate = self;
  }
  return self;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return _songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"prototype-cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] init];
  } else {
    cell.textLabel.text = _songs[indexPath.row].name;
    cell.detailTextLabel.text = _songs[indexPath.row].author;
  }
  
  return cell;
}

# pragma mark - Public API

- (void)startGeneratingForTableView:(UITableView *)tableView;
{
  [tableView registerClass:[RGMockTableViewCell class]
    forCellReuseIdentifier:kMockCellReuseID];
  [NSTimer scheduledTimerWithTimeInterval:1.0f
                                   target:self
                                 selector:@selector(_addRandomSong)
                                 userInfo:nil
                                  repeats:YES];
}

- (void)_addRandomSong
{
  [_urlDataFetcher executeQuery:[self _randomQuery]];
}

- (NSInteger)_tableInsertionPoint
{
  if (_songs.count == 0) {
    return 0;
  }
  return MAX(arc4random_uniform(_songs.count), 0);
}

- (NSString *)_randomQuery
{
  NSString *searchTerm = _sampleSearchTerms[arc4random_uniform(_sampleSearchTerms.count)];
  return [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=3&media=music", searchTerm];
}

# pragma mark - RGDataFetcherDelegate methods

- (void)dataFetcherDidFinishWithResults:(NSArray<id> *)results
                               forQuery:(NSString *)query
{
  RGiTunesTableCellViewModel *randomResult = (RGiTunesTableCellViewModel *)results[arc4random_uniform(results.count)];
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self _tableInsertionPoint]
                                              inSection:0];
  [_songs insertObject:randomResult atIndex:indexPath.row];
  
  __weak __typeof(self) weakSelf = self;
  dispatch_async(dispatch_get_main_queue(), ^{
    __strong __typeof(self) strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf->_tableView insertRowsAtIndexPaths:@[indexPath]
                                    withRowAnimation:UITableViewRowAnimationTop];
    }
  });
}

@end
