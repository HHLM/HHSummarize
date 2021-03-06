//
//  NSString+HHTools.m
//  HHSummarize
//
//  Created by LXH on 2016/11/26.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "NSString+HHTools.h"

@implementation NSString (HHTools)
- (BOOL)isMobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isCarNumber
{
    NSString *carRegex = @"^[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}

- (BOOL)isURL
{
    NSURL *url = [NSURL URLWithString:self];
    if (url && url.host) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (unsigned long long)fileSize{
    
    // 获得文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 标记是否为文件夹
    BOOL isDirectory = NO;
    
    // 首先判断路径是否存在
    BOOL exisit = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    // 路径不存在是马上返回
    if (!exisit) return 0;
    
    // 如果是文件夹
    if (isDirectory) {
        // 文件总大小
        unsigned long long fileSize = 0;
        // 遍历所有文件
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 拼接完整路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 累加文件夹下所有文件
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        return fileSize;
    }
    
    // 如果是文件
    return [mgr attributesOfItemAtPath:self error:nil].fileSize;
    
}
@end
