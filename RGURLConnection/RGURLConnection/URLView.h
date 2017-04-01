//
//  ViewController.h
//  RGURLConnection
//
//  Created by Roshan Goli on 3/21/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol URLViewDelegate;

@interface URLView : UIView

@property (nonatomic, weak, readwrite) id<URLViewDelegate> delegate;

@end

@protocol URLViewDelegate

- (void)URLViewDidTapFetchData:(URLView *)urlView;

@end

