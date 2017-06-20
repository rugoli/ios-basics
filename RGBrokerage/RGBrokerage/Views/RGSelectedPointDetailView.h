//
//  RGSelectedPointDetailView.h
//  RGBrokerage
//
//  Created by Roshan Goli on 6/19/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGSelectedPointDetailView : UIView

@property (nonatomic, readwrite, strong) IBOutlet UILabel *quoteNameLabel;
@property (nonatomic, readwrite, strong) IBOutlet UILabel *quoteValueLabel;

- (void)setQuoteLabelValue:(NSString *)labelValue;
- (void)setQuoteLabelColor:(UIColor *)labelColor;

- (void)setQuoteNameValue:(NSString *)labelValue;
- (void)setQuoteNameColor:(UIColor *)labelColor;


@end
