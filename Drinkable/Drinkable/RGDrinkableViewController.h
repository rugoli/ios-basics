//
//  ViewController.h
//  Drinkable
//
//  Created by Roshan Goli on 4/12/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrinkCounterView;

@interface RGDrinkableViewController : UIViewController

@property (nonatomic, readwrite, weak) IBOutlet DrinkCounterView *counterView;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *counterLabel;

@end

