//
//  UIView+EXT.m
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "UIView+EXT.h"

@implementation UIView (EXT)
- (UIView*)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse
{
    for( UIView* subview in self.subviews ) {
        
        BOOL stop = NO;
        if( recurse( subview, &stop ) )
        {
            return [subview findViewRecursively:recurse];
        }
        else if( stop )
        {
            return subview;
        }
    }
    
    return nil;
}
/*--------------------------- UIView的边框 ---------------------------*/
- (void)clipSquareViewToRound {
    if (self.frame.size.width == self.frame.size.height)
    {
        self.layer.cornerRadius = self.frame.size.width/2;
        self.clipsToBounds = YES;
    }
}
- (void)addBorderLine:(HHBorderDirection)borderDirection
          borderColor:(UIColor *)borderColor
          borderWidth:(CGFloat)borderWidth
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = borderColor.CGColor;
    switch (borderDirection) {
        case HHBorderTop:{
            layer.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
        }
            break;
        case HHBorderBottom:{
            layer.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
        }
            break;
        case HHBorderLeft:{
            layer.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
        }
            break;
        case HHBorderRight:{
            layer.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
        }
            break;
        default:
            break;
    }
    [self.layer addSublayer:layer];
}
- (void)addBottomBorderColor:(UIColor *)boderColor borderWidth:(CGFloat)borderWidth {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = boderColor.CGColor;
    layer.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:layer];
}
- (void)addTopBorderColor:(UIColor *)boderColor borderWidth:(CGFloat)borderWidth {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = boderColor.CGColor;
    layer.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:layer];
}
- (void)addLeftBorderColor:(UIColor *)boderColor borderWidth:(CGFloat)borderWidth {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = boderColor.CGColor;
    layer.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:layer];
}
- (void)addRightBorderColor:(UIColor *)boderColor borderWidth:(CGFloat)borderWidth {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = boderColor.CGColor;
    layer.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:layer];
}
- (void)addBorderColor:(UIColor *)borderColor boderWidth:(CGFloat)borderWidth
{
    [self addBorderColor:borderColor boderWidth:borderWidth cornerPadius:0];
}
- (void)addBorderColor:(UIColor *)borderColor boderWidth:(CGFloat)borderWidth cornerPadius:(CGFloat)cornerPadius {
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.cornerRadius = cornerPadius;
    self.clipsToBounds = YES;
}
@end
