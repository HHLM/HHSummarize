//
//  UIView+CornerRadius.h
//  UISwitch
//
//  Created by HHL on 16/3/15.
//  Copyright © 2016年 LXH. All rights reserved.
//

#import "UIView+CornerRadius.h"

@interface UIView ()

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;

@end

@implementation UIView (CornerRadius)

//圆角
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

//边框宽
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = borderWidth > 0;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

//边框颜色
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = true;
}

- (CGColorRef)borderColor {
    return self.layer.borderColor;
}

@end
