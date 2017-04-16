//
//  RGCornerViewModel.h
//  RGAnimation
//
//  Created by Roshan Goli on 4/16/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGCornerViewModel : NSObject

- (instancetype)initWithPoint:(CGPoint)point
										 xyOffset:(CGPoint)offset;

@property (nonatomic, readonly, assign) CGPoint point;
@property (nonatomic, readonly, assign) CGPoint xyOffset;

@end
