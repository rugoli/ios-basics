//
//  ViewController.h
//  RGAnimation
//
//  Created by Roshan Goli on 4/16/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGAnimatableSquare;
@class RGAnimateButton;

@interface ViewController : UIViewController

@property (atomic, readwrite, strong) IBOutlet RGAnimatableSquare *squareView;
@property (nonatomic, readwrite, strong) IBOutlet RGAnimateButton *animateButton;

@end

