//
//  NSString+EXT.h
//  HHSummarize
//
//  Created by LXH on 16/7/31.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EXT)

/** 是不是正确手机号 */
- (BOOL)isMobileNumber;

/** 是不是车牌号 不包括缩写 比如：粤B  */
- (BOOL)isCarNumber;

/** 清除\n和\r的字符串 */
- (NSString *)cleanString:(NSString *)str;
@end
