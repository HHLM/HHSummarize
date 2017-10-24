//
//  UIImage+EXT.h
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EXT)

//!< 生成二维码
+ (UIImage *)mdQRCodeForString:(NSString *)qrString
                          size:(CGFloat)size;

//!< 生成带颜色的二维码
+ (UIImage *)mdQRCodeForString:(NSString *)qrString
                          size:(CGFloat)size
                     fillColor:(UIColor *)fillColor;
@end
