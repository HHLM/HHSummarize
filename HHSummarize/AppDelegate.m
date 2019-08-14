//
//  AppDelegate.m
//  HHSummarize
//
//  Created by HHL on 16/5/20.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "AppDelegate.h"

#import "HHWindowView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registerLocalNotification:30];
    [self performSelector:@selector(showWindow) withObject:self afterDelay:0.1];
//    [self showWindow];
    return YES;
}
- (void)showWindow
{
    [HHWindowView shareView];
}
/**
 iOS8以后的注册
 */
- (void)registerUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings NS_AVAILABLE_IOS(8_0);
{
    [self registerLocalNotification:30];
}

@end
