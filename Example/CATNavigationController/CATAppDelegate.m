//
//  CATAppDelegate.m
//  CATNavigationController
//
//  Created by lbencs on 06/15/2016.
//  Copyright (c) 2016 lbencs. All rights reserved.
//

#import "CATAppDelegate.h"
#import "CATViewController.h"
#import "CATDogTabViewController.h"
#import "CATCatTableViewController.h"
#import <CATNavigationController/CATNavigationViewController.h>

@implementation CATAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	UIImage *image = [UIImage imageNamed:@"comment_ico_back_pre"];
	image = [image imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
	[[UINavigationBar appearance] setBackIndicatorImage:image];
	
	image = [UIImage imageNamed:@"comment_ico_back_normal"];
	image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	[[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:image];
	
	UITabBarController *tvc = [[UITabBarController alloc] init];
	UITabBarItem *item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:0];
	item1.title = @"History";
	CATViewController *vc1 = [[CATViewController alloc] init];
	CATNavigationViewController *nvc1 = [[CATNavigationViewController alloc] initWithRootViewController:vc1];
	nvc1.tabBarItem = item1;
	
	UITabBarItem *item2 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
	item2.title = @"More";
	CATDogTabViewController *vc2 = [[CATDogTabViewController alloc] init];
	CATNavigationViewController *nvc2 = [[CATNavigationViewController alloc] initWithRootViewController:vc2];
	nvc2.tabBarItem = item2;
	
	UITabBarItem *item3 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:2];
	item3.title = @"Search";
	CATCatTableViewController *vc3 = [[CATCatTableViewController alloc] init];
	vc3.tabBarItem = item3;
	CATNavigationViewController *nvc3 = [[CATNavigationViewController alloc] initWithRootViewController:vc3];
	
	tvc.viewControllers = @[nvc1,nvc2,nvc3];
	
	UIWindow *keyWindow = [[UIWindow alloc] init];
	[keyWindow makeKeyAndVisible];
	keyWindow.rootViewController = tvc;
	
	self.window = keyWindow;
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
