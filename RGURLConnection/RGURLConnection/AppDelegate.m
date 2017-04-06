//
//  AppDelegate.m
//  RGURLConnection
//
//  Created by Roshan Goli on 3/21/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "URLViewController.h"

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{	
	self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
	
	URLViewController *viewController = [[URLViewController alloc] init];
	
	self.window.rootViewController = viewController;
	[self.window makeKeyAndVisible];
	
	return YES;
}

@end
