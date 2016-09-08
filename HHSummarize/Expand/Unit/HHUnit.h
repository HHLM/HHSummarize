//
//  HHUnit.h
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HHUnit : NSObject

#pragma mark ----图片处理-----
/**
 *  根据imageView宽高比例获取对应比例的图片
 *
 *  @param scale 宽高之比
 *  @param image 原图
 *
 *  @return 处理后的图片
 */
+ (UIImage *)imageWithScale:(CGFloat)scale image:(UIImage *)image;

/**
 *  等比压缩图片
 *
 *  @param image     原图
 *  @param scaleSize 压缩比例
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/**
 *  图片翻转正常
 *
 *  @param aImage 原图
 *
 *  @return 处理的图片
 */
+ (UIImage *)rotateImage:(UIImage *)aImage;

/**
 *  生成纯色图片的函数
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  获取圆形图片
 *
 *  @param image  原图
 *  @param size   尺寸
 *  @param radius 半径
 *
 *  @return 处理后的图片
 */
+(UIImage *)roundImage:(UIImage *) image toSize:(CGSize)size radius: (float) radius;

@end
