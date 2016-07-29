//
//  HHCopyLabel.m
//  HHSummarize
//
//  Created by LXH on 16/7/29.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHCopyLabel.h"

@implementation HHCopyLabel


{
    UILongPressGestureRecognizer *longPress;  //长按手势
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addLongPressGestuer];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addLongPressGestuer];
}
- (void)setClickCopy:(BOOL)clickCopy {
    if (clickCopy) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(copyString:)];
        
        [self addGestureRecognizer:tapGesture];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(hideMenu)
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
        
        [self removeGestureRecognizer:longPress];
    }
}
- (void)addLongPressGestuer
{
    self.userInteractionEnabled = YES;
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(copyString:)];
    [self addGestureRecognizer:longPress];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideMenu)
                                                 name:UIMenuControllerDidHideMenuNotification
                                               object:nil];
}
- (void)hideMenu
{
    if (self.normalColor) {
        [self resignFirstResponder]; //取消第一响应
        self.backgroundColor = self.normalColor;
        self.normalColor = nil;
    }
}
- (void)copyString:(UILongPressGestureRecognizer *)sender
{
//    if ([UIMenuController sharedMenuController].menuVisible) {
//        return;
//    }
    //不成为第一响应者无法弹出UIMenuController
    [self becomeFirstResponder];
    //微信朋友圈长按出现的颜色
    [self setHeightedBackgroundColor];
    //NSLocalizedString(@"copy", @"");
    
    /**
     UIMenuItem *menuItem1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(begainCopy:)];
     UIMenuItem *menuItem2 = [[UIMenuItem alloc] initWithTitle:@"备注" action:@selector(begainCopy:)];
     UIMenuItem *menuItem3 = [[UIMenuItem alloc] initWithTitle:@"更多" action:@selector(begainCopy:)];
     [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:menuItem1,menuItem2,menuItem3,nil]];
     */
    UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                      action:@selector(begainCopy:)];
    [[UIMenuController sharedMenuController] setMenuItems:@[copyLink]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
}
//设置高亮颜色,这里取的为朋友圈文字被选中时的颜色
- (void)setHeightedBackgroundColor
{
    if (!self.normalColor) {
        self.normalColor = self.backgroundColor;
        self.backgroundColor = self.highLightColor?:[UIColor colorWithRed:((float)((0xc7c7c5 & 0xFF0000) >> 16))/255.0 green:((float)((0xc7c7c5 & 0xFF00) >> 8))/255.0 blue:((float)(0xc7c7c5 & 0xFF))/255.0 alpha:1.0];
    }
}
//为了能接收到事件（能成为第一响应者），我们需要覆盖一个方法：
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
//还需要针对复制的操作覆盖两个方法：
// 可以响应的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(begainCopy:));
}

//复制
-(void)begainCopy:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
    DLog(@"拷贝文字:%@",pasteboard.string);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
}
@end
