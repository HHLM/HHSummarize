//
//  UITextField+EXT.m
//  HHSummarize
//
//  Created by LXH on 2017/10/24.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "UITextField+EXT.h"

@implementation UITextField (EXT)

- (void)leftMargin:(CGFloat)margin {
    UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, margin, CGRectGetHeight(self.frame))];
    left.backgroundColor = [UIColor clearColor];
    left.userInteractionEnabled = NO;
    self.leftView = left;
    self.leftViewMode = UITextFieldViewModeAlways;
}
- (void)rightMargin:(CGFloat)margin {
    UIView *right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, margin, CGRectGetHeight(self.frame))];
    right.backgroundColor = [UIColor clearColor];
    right.userInteractionEnabled = NO;
    self.rightView = right;
    self.rightViewMode = UITextFieldViewModeAlways;
}
- (void)setPlaceholderColor:(UIColor *)holderColor {
    [self setValue:holderColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setplaceholderFont:(UIFont *)holderfont {
    [self setValue:holderfont forKeyPath:@"_placeholderLabel.font"];
}
@end
