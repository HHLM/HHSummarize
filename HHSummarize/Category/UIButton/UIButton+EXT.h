//
//  UIButton+EXT.h
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, HHImagePosition) {
    
    HHImagePositionLeft     = 0,            //图片在左，文字在右，默认
    HHImagePositionRight    = 1,            //图片在右，文字在左
    HHImagePositionTop      = 2,            //图片在上，文字在下
    HHImagePositionBottom   = 3,            //图片在下，文字在上
};

@interface UIButton (EXT)
/**
 *  @brief  设置按钮额外热区
 */
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;


/*--------------------标题颜色--------------*/
- (void)normalTitleColor:(UIColor*)color;

- (void)highltTitleColor:(UIColor*)color;

- (void)selectTitleColor:(UIColor*)color;



/*------------------- 标 题  --------------*/
- (void)normalTitle:(NSString *)title;  //正常状态

- (void)highltTitle:(NSString *)title;  //高亮

- (void)selectTitle:(NSString *)title;  //选中



/*--------------------图片----------------*/
- (void)normalImage:(NSString *)imgName;// 正常

- (void)highltImage:(NSString *)imgName;//高亮

- (void)selectImage:(NSString *)imgName;//选中


/*--------------------背景图片--------------*/
- (void)normalBackgroundImage:(NSString *)imgName;//正常背景图

- (void)highltBackgroundImage:(NSString *)imgName;//高亮

- (void)selectBackgroundImage:(NSString *)imgName;//选中


/*--------------------图文混排--------------*/
/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(HHImagePosition)postion spacing:(CGFloat)spacing;
@end
