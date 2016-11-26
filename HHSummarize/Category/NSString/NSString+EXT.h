//
//  NSString+EXT.h
//  HHSummarize
//
//  Created by LXH on 16/7/31.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EXT)

/** 
 清除\n和\r的字符串
*/
- (NSString *)cleanString:(NSString *)str;

/** 
 判断是不是空字符串  YES 是
*/
- (BOOL)isEmptyString;

/**
 去除字符串中得空格
 */
- (NSString *)stringByRemovingSpace;

/**
 去除首尾空格
 */
- (NSString *)stringByTrimmingSpace;
/** 
 删除数组的空格元素
*/
- (NSArray *)cleanSpaceArray:(NSArray *)array;
@end
