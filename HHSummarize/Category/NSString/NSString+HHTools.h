//
//  NSString+HHTools.h
//  HHSummarize
//
//  Created by LXH on 2016/11/26.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HHTools)
/**
 是不是正确手机号
 */
- (BOOL)isMobileNumber;

/**
 是不是车牌号 不包括缩写 比如：粤B
 */
- (BOOL)isCarNumber;

/**
 是不是网址
 */
- (BOOL)isURL;

/** 文件大小 */
- (unsigned long long)fileSize;
@end
