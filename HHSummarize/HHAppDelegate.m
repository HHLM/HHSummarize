//
//  HHAppDelegate.m
//  HHSummarize
//
//  Created by HHL on 16/7/26.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHAppDelegate.h"

@implementation HHAppDelegate


// 设置本地通知
- (void)registerLocalNotification:(NSInteger)alertTime
{
    
    UILocalNotification *notifications = [[UILocalNotification alloc] init];
    
    //出发通知时间
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    
    notifications.fireDate = date;
    
    notifications.timeZone = [NSTimeZone defaultTimeZone];
    
    notifications.repeatInterval = kCFCalendarUnitSecond;
    
    //通知内容
    notifications.alertBody = @"小伙子加油啊...";
    
    notifications.applicationIconBadgeNumber = 3;
    
    // 通知被触发时播放的声音
    notifications.soundName = @"eyd_cry.caf"; //自定义的声音
    
    NSDictionary *keys = @{@"key":@"在不努力你什么没有了!!!"};
    
    notifications.userInfo = keys;
    
    //iOS以后 需要注册者这个才能授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType  type = UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
        
        //通知重复提示时间单位
        notifications.repeatInterval = NSCalendarUnitDay;
    }else {
        notifications.repeatInterval = NSCalendarUnitDay;
    }
    
    //注册本地通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notifications];;
    
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSString *notMess = [notification.userInfo objectForKey:@"key"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"小伙伴通知来了"
                                                    message:notMess
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    NSLog(@"小圆点的个数：%ld",badge);
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    DLog(@"deviceToken:%@",deviceToken);
}


/*
 接收推送消息
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    // IOS 7 Support Required
//}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)showJPushDetailsView:(NSDictionary *)recDic
{
}
//告诉代理启动基本完成程序准备开始运行
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}


//当应用程序将要入非活动状态执行，在此期间，应用程序不接收消息或事件，比如来电话了
- (void)applicationWillResignActive:(UIApplication *)application
{
    DLog(@"非执行活动中");
}

//当应用程序入活动状态执行，这个刚好跟上面那个方法相反
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    DLog(@"进入执行状态");
}

//当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    DLog("程序进入后台执行");
}


//当程序从后台将要重新回到前台时候调用，这个刚好跟上面的那个方法相反。
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    DLog(@"程序进入前台执行");
//    [application setApplicationIconBadgeNumber:0];
//    [application cancelAllLocalNotifications];
}


//当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
- (void)applicationWillTerminate:(UIApplication *)application
{
    DLog(@"程序即将退出");
}


//当程序载入后执行
- (void)applicationDidFinishLaunching:(UIApplication*)application
{
    DLog(@"当程序载入后执行");
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    if (url) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"应用唤醒"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    return YES;
}
@end
