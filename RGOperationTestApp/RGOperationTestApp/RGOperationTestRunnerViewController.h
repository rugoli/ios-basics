//
//  ViewController.h
//  RGOperationTestApp
//
//  Created by Roshan Goli on 9/11/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGOperationTestRunnerViewController : UIViewController

@property (nonatomic, readwrite, weak) IBOutlet UIButton *serialTestButton;
@property (nonatomic, readwrite, weak) IBOutlet UIButton *testWithDependencies;

@end

