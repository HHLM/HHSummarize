//
//  UIView+Animation.m
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

/**
 动画速度,何时快、慢
 kCAMediaTimingFunctionLinear 线性（匀速）|
 kCAMediaTimingFunctionEaseIn 先慢|
 kCAMediaTimingFunctionEaseOut 后慢|
 kCAMediaTimingFunctionEaseInEaseOut 先慢 后慢 中间快|
 kCAMediaTimingFunctionDefault 默认|
 )
 */

/**
 1 const kCAAnimationLinear     //线性，默认
 2 const kCAAnimationDiscrete   //离散，无中间过程，但keyTimes设置的时间依旧生效，物体跳跃地出现在各个关键帧上
 3 const kCAAnimationPaced      //平均，keyTimes跟timeFunctions失效
 4 const kCAAnimationCubic      //平均，同上
 5 const kCAAnimationCubicPaced //平均，同上
 */

/*动画效果
 kCATransitionFade      淡出|
 kCATransitionMoveIn    覆盖原图|
 kCATransitionPush      推出|
 kCATransitionReveal    底部显出来
 */

/*transform  改变
Table 4 CATransform3D key paths
Field Key Path Description
rotation.x 在X轴上以弧度为单位旋转.
rotation.y 在Y轴上以弧度为单位旋转.
rotation.z 在Z轴上以弧度为单位旋转.
rotation   在
 
scale.x X轴放大缩小.
scale.y Y轴放大缩小.
scale.z Z轴放大缩小.
scale   在所有轴上缩放.
 
translation.x 在X轴上移动.
translation.y 在Y轴上移动.
translation.z 在Z轴上移动.
translation   在所有上面移动
*/

//左右摆动的动画效果
- (void)shakeHorizontally {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    //动画的快慢效果
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //动画持续时间
    animation.duration = 5.5;
    
    //动画的运动轨迹
    animation.values = @[@(-20), @(20),@(-12), @(12), @(-8), @(8), @(-4), @(4), @(0)];

    
    [self.layer addAnimation:animation forKey:@"shake"];
}


- (void)shakeVertically {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    animation.duration = 0.5;
    
    animation.values = @[@(-12), @(12), @(-8), @(8), @(-4), @(4), @(0)];
    
    [self.layer addAnimation:animation forKey:@"shake"];
}

//!< 主要用于输入框
- (void)animationForTextField {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat currentTx = self.transform.tx;
    
    animation.delegate = self;
    animation.duration = 1.f;
    animation.values = @[ @(currentTx), @(currentTx + 10), @(currentTx-8), @(currentTx + 8), @(currentTx -5), @(currentTx + 5), @(currentTx) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode = @"backwards";
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"kAFViewShakerAnimationKey"];
}

- (void)bounceAnimation {
    [UIView animateWithDuration:.1f animations:^{
        self.transform = CGAffineTransformMakeScale(.8f, .8f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1f animations:^{
            self.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.1f animations:^{
                self.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

- (void)applyMotionEffects {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0)
    {
        UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalEffect.minimumRelativeValue = @(-10.0f);
        horizontalEffect.maximumRelativeValue = @(10.0f);
        
        UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalEffect.minimumRelativeValue = @(-10.0f);
        verticalEffect.maximumRelativeValue = @(10.0f);
        
        UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
        group.motionEffects = @[horizontalEffect,verticalEffect];
        [self addMotionEffect:group];
    }
}
- (void)pulseToSize:(CGFloat)scale
           duration:(NSTimeInterval)duration
             repeat:(BOOL)repeat
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
   
    pulseAnimation.duration = duration;
    
    pulseAnimation.toValue = [NSNumber numberWithInt:scale];
   
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //永久重复的话设置为HUGE_VALF。
    pulseAnimation.autoreverses = repeat ? HUGE_VALF : 0;
    
    [self.layer addAnimation:pulseAnimation forKey:@"pilse"];
}

- (void)flipWithDuration:(NSTimeInterval)duration
               direction:(UIViewAnimationFlipDirection)direction
             repeatCount:(NSUInteger)repeatCount
             autoreverse:(BOOL)shouldAutoreverse
{
    NSString *subType = nil;
    switch (direction) {
        case UIViewAnimationFlipDirectionFromTop:
            subType = @"fromTop";
            break;
        case UIViewAnimationFlipDirectionFromBottom:
            subType = @"fromBottom";
            break;
        case UIViewAnimationFlipDirectionFromLeft:
            subType = @"fromLeft";
            break;
        case UIViewAnimationFlipDirectionFromRight:
            subType = @"fromRight";
            break;
            
        default:
            break;
    }
    CATransition *transiton = [CATransition animation];
    
    /**
     @"cube"  立方体效果
     @"moveIn"
     @"reveal"
     @"fade"(default) 
     @"pageCurl"        向上翻页
     @"pageUnCurl"      向下翻页
     @"suckEffect"      收缩效果，如一块布被抽走
     @"rippleEffect"    滴水效果
     @"oglFlip"         上下翻页效果
     */
    
    
    transiton.startProgress = 0.f;
    transiton.endProgress = 1.0f;
    transiton.type = @"flip";
    transiton.subtype = subType;
    
    //动画时长（秒为单位）
    transiton.duration = duration;
    
    //重复次数。永久重复的话设置为HUGE_VALF。
    transiton.repeatCount = repeatCount;
    
    //动画结束时是否执行逆动画
    transiton.autoreverses = shouldAutoreverse;
    [self.layer addAnimation:transiton forKey:@"spin"];
}

- (void)rotateToAngle:(CGFloat)angle
             duration:(NSTimeInterval)duration
            direction:(UIViewAnimationRotationDirection)direction
          repeatCount:(NSUInteger)repeatCount
          autoreverse:(BOOL)shouldAutoreverse
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //fromValue  开始值
    //toValue    终了值（绝对值）
    //byValue    终了值（相对值）
    
    rotateAnimation.toValue = @(direction == UIViewAnimationRotationDirectionRight ? angle: -angle);
    rotateAnimation.autoreverses = shouldAutoreverse;
    rotateAnimation.repeatCount = repeatCount;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    rotateAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:rotateAnimation forKey:@"transform.rotation.z"];
}

- (void)stopAnimation {
    [CATransaction begin];
    [self.layer removeAllAnimations];
    [CATransaction commit];
    [CATransaction flush];
}
- (BOOL)isBeingAnimated {
    return [self.layer.animationKeys count];
}
@end
