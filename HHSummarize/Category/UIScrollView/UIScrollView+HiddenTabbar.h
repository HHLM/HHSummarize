//
//  UIScrollView+HiddenTabbar.h
//  AiQiangGou
//
//  Created by 朱李宏 on 15/5/20.
//  Copyright (c) 2015年 Doweidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HiddenTabbar)

/*!滚动到view的底部与键盘对齐，做偏移offsetY
 */
- (void)scrollToViewBottom:(UIView *)view
              KeyboardShow:(NSNotification *) notific
                   OffsetY:(CGFloat)offsetY
                  Animated:(BOOL)animated;

@end
