//
//  UIScrollView+HiddenTabbar.m
//  AiQiangGou
//
//  Created by 朱李宏 on 15/5/20.
//  Copyright (c) 2015年 Doweidu. All rights reserved.
//

#import "UIScrollView+HiddenTabbar.h"
#import <objc/runtime.h>

@implementation UIScrollView (HiddenTabbar)

/*!滚动到view的底部与键盘对齐，做偏移offsetY
 */
- (void)scrollToViewBottom:(UIView *)view
              KeyboardShow:(NSNotification *) notific
                   OffsetY:(CGFloat)offsetY
                  Animated:(BOOL)animated
{
    //获取textfield当前在window上得坐标
    
    CGPoint pointViewConWindow = [[UIApplication sharedApplication].keyWindow convertPoint:CGPointMake(0, CGRectGetMaxY(view.bounds)) fromView:view];
    
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[view convertRect: view.bounds toView:window];

    NSLog(@"%f-------",rect.origin.y);

    
    //获取键盘高度和坐标
    CGRect keyboardRect = [notific.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat pointYView = pointViewConWindow.y + self.contentOffset.y;
    
    
    
    CGFloat pointYWindow = CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(keyboardRect);
    
    CGFloat dY = pointYView - pointYWindow;
    
    CGFloat endOffsetY = dY + offsetY;
    
    
    if (endOffsetY < 0) {
        return;
    }
    [self setContentOffset:CGPointMake(0, 0) animated:NO];
    if (keyboardRect.origin.y == CGRectGetHeight([UIScreen mainScreen].bounds)) {
         NSLog(@"%f-",self.contentOffset.y);
        [self setContentOffset:CGPointMake(0, -self.contentOffset.y) animated:animated];
        NSLog(@"%f-",self.contentOffset.y);
        

    }else
    {
        NSLog(@"%f++++++",self.contentOffset.y);
        [self setContentOffset:CGPointMake(0, endOffsetY) animated:animated];
        NSLog(@"%f++++++",self.contentOffset.y);
    }
    
}

@end
