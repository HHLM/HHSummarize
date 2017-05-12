//
//  HHCirculateView.h
//  HHSummarize
//
//  Created by LXH on 2017/5/11.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 文字所在的方向
 */

typedef NS_ENUM(NSInteger ,HHTextAlignment) {
    HHTextAlignmentLeft   = 0, //默认文字在左边
    HHTextAlignmentRight  = 1,
    HHTextAlignmentCenter = 2
};

typedef void (^HHCirculateblock)(NSInteger index);

@interface HHCirculateView : UIView

@property (nonatomic, copy) HHCirculateblock  block;

#pragma mark -- 数据源
// 文字标题
@property (nonatomic, strong) NSArray *titleArray;

// 网络图片
@property (nonatomic, strong) NSArray *imageURLArray;

// 本地图片
@property (nonatomic, strong) NSArray *imageArray;

// 占位图，用于网络未加载到图片时
@property (nonatomic, strong) UIImage *placeholderImage;


#pragma mark -- 控制接口

@property (nonatomic, assign) CGFloat autoSrollerTimerInterval; //自动滚动时间间隔
//
@property (nonatomic, assign) BOOL autoSroller; //是否自动滚动 默认自动滚动

/**
 字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 展示view的颜色
 */
@property (nonatomic, strong) UIColor *showViewColor;

/**
 字体大小
 */
@property (nonatomic, strong) UIFont *textFout;
/**
 文字所在位置
 */
@property (nonatomic, assign) HHTextAlignment textAliment;

/**
 是否显示分页控件
 */
@property (nonatomic, assign) BOOL showPageControl;

@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

@end
