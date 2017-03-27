//
//  Device.h
//  HHSummarize
//
//  Created by HHL on 16/7/31.
//  Copyright © 2016年 HHL. All rights reserved.
//

#ifndef Device_h
#define Device_h

//应用程序
#define HHAppDelegateInstall    ((AppDelegate*)([UIApplication sharedApplication].delegate))


//判断系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IOS5   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IOS6   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IOS7   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS9   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

//判断设备
#define IPHONE4     (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IPHONE5     (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IPHONE6     (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IPHONE6P    (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)



//屏幕宽度和高度

#define HHEIGHT           [UIScreen mainScreen].bounds.size.height
#define HWIDTH            [UIScreen mainScreen].bounds.size.width

#define KWINOW            [UIApplication sharedApplication].keyWindow


/**
 *  打印在Debug情况下才会打印
 */
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif


/**
 *  或者只是标记那一行
 */
#define MARK    NSLog(@"\nMARK: %s -- 第%d行", __PRETTY_FUNCTION__, __LINE__);

// 判断字符串是否为空

#define IFSTRING(v)             (v = (v != nil) ? v : @"")

// 判断是不是字符串
#define IFISSTR(v)              (v = ([v isKindOfClass:[NSString class]]) ? v : [NSString stringWithFormat:@"%@",v])
/*----------------------分割-----------------------*/

#pragma mark - 文件
//NSUserDefaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#pragma mark - Info.Plist
//plist文件内容
#define InfoPlistDic              [[NSBundle mainBundle] infoDictionary]

#define ReadInfoPlistDic(_name)   [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)_name] //获取infoPlist文件中的 属性

#define AppVersion                  ReadInfoPlistDic(kCFBundleVersionKey)      //APP 版本

#define AppBundleIdentifier         ReadInfoPlistDic(kCFBundleIdentifierKey)   //

#define TICK   NSDate *startTime = [NSDate date]

#define TOCK   NSLog(@"Time: %f", -[[NSDate date] timeIntervalSinceNow])


#pragma mark - Setting
//当前系统设置国家的country iso code
#define countryISO  [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode]

//当前系统设置语言的iso code
#define languageISO [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)

#define radianToDegrees(radian) (radian*180.0)/(M_PI)




#endif /* Device_h */
