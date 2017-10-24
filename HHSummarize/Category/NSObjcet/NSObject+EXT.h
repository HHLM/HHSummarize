//
//  NSObject+EXT.h
//  HHSummarize
//
//  Created by LXH on 16/7/31.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EXT)
/**
 json字符串转字典或者数组
 */
- (id)objecWithJsonString:(NSString *)jsonString;

/**
 字典或者数组转json字符串
 */
- (NSString *)jsonStringWithObject:(id)object;

/**
 *  通过运行时获取所有属性
 */
+ (void)logAllIvars;
@end
