//
//  UIView+Frame.m
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x             /** 改变x坐标 */
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setY:(CGFloat)y             /** 改变y坐标 */
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width     /** 改变宽度 */
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height    /** 改变高度 */
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)origin    /** 改变x和y的坐标 */
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame =frame;
}
- (void)setSize:(CGSize)size         /** 改变frame */
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}
- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX /** < 改变中心x坐标 > */
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center =center;
}
- (void)setCenterY:(CGFloat)centerY /** < 改变中心y坐标 > */
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center =center;
}

/*--------------------get方法-----------------*/
- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}
- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}
- (CGPoint)origin
{
    return self.frame.origin;
}
- (CGSize)size
{
    return self.frame.size;
}
- (CGFloat)centerY              /** < 获取中心y坐标 > */
{
    return self.center.y;
}
- (CGFloat)centerX              /** < 获取中心x坐标 > */
{
    return self.center.x;
}
- (CGFloat)right               /** < 获取右边x坐标 > */
{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)bottom              /** < 获取下面y坐标 > */
{
    return CGRectGetMaxY(self.frame);
}
/*--------------------------- 放大缩小 ---------------------------*/
/** 移动 */
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

/** 缩放 */
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}
/** 在给定的尺寸内缩小 */
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;	
}
@end
