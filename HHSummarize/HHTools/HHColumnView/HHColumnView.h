//
//  HHColumnView.h
//  HHSummarize
//
//  Created by LXH on 2016/12/14.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+Frame.h"
typedef NS_ENUM(NSInteger,HHColumnType){
    
    HHColumnLineType    = 0,    //下划线
    HHColumnRoundType   = 1,    //背景色
    HHColumnTextType    = 2     //文字
};

@protocol HHColumnViewDelegate;

@interface HHColumnView : UIScrollView
/**
 重构init方法
 */
- (instancetype)initWithFrame:(CGRect)frame
                    styleType:(HHColumnType)styleType;
/**
 标题个数
 */
@property (nonatomic, copy) NSArray *columnArray;
/**
 选中的颜色 默认红色
 */
@property (nonatomic, strong) UIColor *itemSelectColor;
/**
 默认颜色  默认是灰色
 */
@property (nonatomic, strong) UIColor *itemDefaultColor;
/**
 滑块颜色 默认红色
 */
@property (nonatomic, strong) UIColor *roundColor;
/**
 间距
 */
@property (nonatomic, assign) CGFloat itemMargin;
/**
 字体大小
 */
@property (nonatomic, assign) CGFloat itemFontSize;

/**
 代理方法
 */
@property (nonatomic, weak)  id <HHColumnViewDelegate> columnDelegate;

/**
 选中某一个按钮
 */
- (void)selectItemAtIndex:(NSInteger)index;

@end

@protocol HHColumnViewDelegate <NSObject>

//点击选中的item
- (void)columunViewSelectItem:(NSInteger)item;

@end
