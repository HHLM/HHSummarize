//
//  UILabel+autoSize.h
//  HHSummarize
//
//  Created by LXH on 16/7/29.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (autoSize)
/**
 *  x y 坐标  高度不变 改变水平宽度
 */
- (UILabel *)autoSizeHorizontal;

/**
 *  x y 坐标 宽度不变 改变高度
 */
- (UILabel *)autoSizeVertical;

/**
 *  不能小于这个宽度
 *
 *  @param minWidth label的最小宽度
 *
 *  @return label
 */
- (UILabel *)autoSizeHorizontal:(CGFloat)minWidth;
/**
 *  不能小于这个高度
 *
 *  @param minHeigh label的最小高度
 *
 *  @return label
 */
- (UILabel *)autoSizeVertical:(CGFloat)minHeigh;
@end
