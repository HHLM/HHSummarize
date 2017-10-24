//
//  UITextField+EXT.h
//  HHSummarize
//
//  Created by LXH on 2017/10/24.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (EXT)
//!< 设置左边距
- (void)leftMargin:(CGFloat)margin;
//!< 设置右边距
- (void)rightMargin:(CGFloat)margin;
//!< 设置默认字体颜色
- (void)setPlaceholderColor:(UIColor *)holderColor;
//!< 设置默认字体大小
- (void)setplaceholderFont:(UIFont *)holderfont;
@end
