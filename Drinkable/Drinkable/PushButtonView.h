//
//  PushButtonView.h
//  Drinkable
//
//  Created by Roshan Goli on 4/12/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface PushButtonView : UIButton

@property (nonatomic, readonly, strong) IBInspectable UIColor *buttonColor;
@property (nonatomic, readonly, assign) IBInspectable BOOL isAddButton;

@end
