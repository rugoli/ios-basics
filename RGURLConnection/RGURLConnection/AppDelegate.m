//
//  AppDelegate.m
//  RGURLConnection
//
//  Created by Roshan Goli on 3/21/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
	
	ViewController *viewController = [[ViewController alloc] init];
	
	self.window.rootViewController = viewController;
	[self.window makeKeyAndVisible];
	
	return YES;
}

@end
