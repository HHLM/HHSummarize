//
//  UIView+DisPlaying.m
//  HHSummarize
//
//  Created by LXH on 2017/7/21.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "UIView+DisPlaying.h"

@implementation UIView (DisPlaying)

- (BOOL)isDisPalyedInScreen {
    if (self == nil) {
        return NO;
    }
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    //转换view 对应的window的rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return  NO;
    }
    
    //若隐藏
    if (self.hidden) {
        return NO;
    }
    
    //没有父试图
    if (self.superview == nil) {
        return NO;
    }
    
    //若size 是CGSizezero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  NO;
    }
    
    //获取 view 和 widow交叉的rect
    CGRect insertsectionRect = CGRectIntersection(rect, screenRect);
    
    if (CGRectIsEmpty(insertsectionRect) || CGRectIsNull(insertsectionRect)) {
        return  NO;
    }
    
    return  YES;
    
}
@end
