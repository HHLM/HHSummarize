//
//  UIView+EXT.h
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  添加边框的位置
 */
typedef NS_ENUM(NSInteger ,HHBorderDirection) {
    
    HHBorderTop     = 0, //上
    
    HHBorderBottom  = 1, //下
    
    HHBorderLeft    = 2, //左
    
    HHBorderRight   = 3  //右
};

@interface UIView (EXT)

//!< 递归遍历父view
- (UIView*)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;

//!< 将一个正方形的View剪切成一个圆
- (void)clipSquareViewToRound;

/**
 *  添加线条
 *
 *  @param borderDirection 添加边框方向
 *  @param boderColor      边框颜色
 *  @param borderWidth     边框宽度
 */
- (void)addBorderLine:(HHBorderDirection)borderDirection
          borderColor:(UIColor *)borderColor
          borderWidth:(CGFloat)borderWidth;

/** 切一个圆形图片*/
+ (UIImage *)imageRoundSize:(CGFloat)cornerRadius image:(UIImage *)image;

/** 四周添加边线 无弧度 */
- (void)addBorderColor:(UIColor *)borderColor boderWidth:(CGFloat)borderWidth;

/** 添加带弧度的边线 */
- (void)addBorderColor:(UIColor *)borderColor boderWidth:(CGFloat)borderWidth cornerPadius:(CGFloat)cornerPadius;
@end
