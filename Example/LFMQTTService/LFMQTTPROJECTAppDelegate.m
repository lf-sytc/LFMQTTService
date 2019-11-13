//
//  LFMQTTPROJECTAppDelegate.m
//  LFMQTTService
//
//  Created by lf_sytc@hotmail.com on 09/10/2019.
//  Copyright (c) 2019 lf_sytc@hotmail.com. All rights reserved.
//

#import "LFMQTTPROJECTAppDelegate.h"
#import "LFMQTTPROJECTViewController.h"
@implementation LFMQTTPROJECTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LFMQTTPROJECTViewController alloc] init]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
//    [[LFMQTTService sharedInstance] endToConnect:^(NSError *error) {
//        NSLog(@"断开连接 %@",error);
//    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[LFMQTTService sharedInstance] startToConnect:^(NSError *error) {
        NSLog(@"链接成功 %@ ",error);
    }];
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
