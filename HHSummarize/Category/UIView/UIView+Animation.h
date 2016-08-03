//
//  UIView+Animation.h
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  碰撞
 */
typedef NS_ENUM(NSUInteger, UIViewAnimationFlipDirection) {
    /**
     *  上
     */
    UIViewAnimationFlipDirectionFromTop,
    /**
     *  左
     */
    UIViewAnimationFlipDirectionFromLeft,
    /**
     *  右
     */
    UIViewAnimationFlipDirectionFromRight,
    /**
     *  下
     */
    UIViewAnimationFlipDirectionFromBottom,
};

/**
 *  旋转的
 */
typedef NS_ENUM(NSUInteger, UIViewAnimationRotationDirection) {
    /**
     *  右边旋转
     */
    UIViewAnimationRotationDirectionRight,
    /**
     *  左边旋转
     */
    UIViewAnimationRotationDirectionLeft
};


@interface UIView (Animation)

//!< 增强运动效果
- (void)applyMotionEffects;

//!< 水平震动
- (void)shakeHorizontally;

//!< 竖直方向震动
- (void)shakeVertically;

//!< 开始动画
- (BOOL)isBeingAnimated;

//!< 结束动画
- (void)stopAnimation;

/**
 *  执行试图上脉冲动画
 *
 *  @param scale    放大倍数
 *  @param duration 动画持续时间
 *  @param repeat   是否重复
 */
- (void)pulseToSize:(CGFloat)scale
           duration:(NSTimeInterval)duration
             repeat:(BOOL)repeat;

/**
 *  围绕X或者Y三维状的翻转动画
 *
 *  @param duration          持续时间
 *  @param direction         翻转运动方向
 *  @param repeatCount       重复次数
 *  @param shouldAutoreverse YES 终点时候逆序
 */
- (void)flipWithDuration:(NSTimeInterval)duration
               direction:(UIViewAnimationFlipDirection)direction
             repeatCount:(NSUInteger)repeatCount
             autoreverse:(BOOL)shouldAutoreverse;

/**
 *  旋转
 *
 *  @param angle             旋转角度
 *  @param duration          持续时间
 *  @param direction         方向
 *  @param repeatCount       重复次数
 *  @param shouldAutoreverse YES 终点时候动画逆转
 */
- (void)rotateToAngle:(CGFloat)angle
             duration:(NSTimeInterval)duration
            direction:(UIViewAnimationRotationDirection)direction
          repeatCount:(NSUInteger)repeatCount
          autoreverse:(BOOL)shouldAutoreverse;

@end
