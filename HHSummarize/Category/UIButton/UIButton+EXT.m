//
//  UIButton+EXT.m
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "UIButton+EXT.h"
#import <objc/runtime.h>
@implementation UIButton (EXT)
/**
 *  设置标题颜色
 *
 *  @param color 颜色
 */
- (void)normalTitleColor:(UIColor*)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}
- (void)highltTitleColor:(UIColor*)color
{
    [self setTitleColor:color forState:UIControlStateHighlighted];
}
- (void)selectTitleColor:(UIColor*)color
{
    [self setTitleColor:color forState:UIControlStateSelected];
}
/**
 *  设置标题名称
 *
 *  @param title string
 */
- (void)normalTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)highltTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateHighlighted];
}
- (void)selectTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateSelected];
}
/**
 *  设置图片
 *
 *  @param imgName image
 */
- (void)normalImage:(NSString *)imgName
{
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}
- (void)highltImage:(NSString *)imgName
{
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];;
}
- (void)selectImage:(NSString *)imgName
{
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected];;
}

- (void)normalBackgroundImage:(NSString *)imgName;//正常背景图
{
    [self setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}
- (void)highltBackgroundImage:(NSString *)imgName;//高亮
{
    [self setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
}
- (void)selectBackgroundImage:(NSString *)imgName;//选中
{
    [self setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected];
}

#pragma mark -- 按钮上图文混排
/**
 *  按钮上的图文混排
 *
 *  @param postion 位置
 *  @param spacing 距离
 */
- (void)setImagePosition:(HHImagePosition)postion spacing:(CGFloat)spacing {
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    CGFloat imageOffsetX = (imageWith + labelWidth) / 2 - imageWith / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;               //image中心移动的y距离
    CGFloat labelOffsetX = (imageWith + labelWidth / 2) - (imageWith + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    switch (postion) {
        case HHImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            break;
            
        case HHImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight + spacing/2), 0, imageHeight + spacing/2);
            break;
            
        case HHImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            break;
            
        case HHImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            break;
            
        default:
            break;
    }
}

#pragma mark -- 添加点击区域
- (UIEdgeInsets)touchAreaInsets
{
    return [objc_getAssociatedObject(self, @selector(touchAreaInsets)) UIEdgeInsetsValue];
}
/**
 *  @brief  设置按钮额外热区
 */
- (void)setTouchAreaInsets:(UIEdgeInsets)touchAreaInsets
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    UIEdgeInsets touchAreaInsets = self.touchAreaInsets;
    CGRect bounds = self.bounds;
    DLog(@"%f---%f--%f---%f",self.bounds.size.width,self.bounds.size.height,self.bounds.origin.x,self.bounds.origin.y);
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    DLog(@"%f---%f--%f---%f",bounds.size.width,bounds.size.height,self.bounds.origin.x,self.bounds.origin.y);
    
    return CGRectContainsPoint(bounds, point);
}
@end
