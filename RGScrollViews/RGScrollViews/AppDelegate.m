//
//  AppDelegate.m
//  RGScrollViews
//
//  Created by Roshan Goli on 4/9/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "AppDelegate.h"
#import "RGScrollViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.rootViewController = [[RGScrollViewController alloc] init];
	[self.window makeKeyAndVisible];
	return YES;
}

@end
