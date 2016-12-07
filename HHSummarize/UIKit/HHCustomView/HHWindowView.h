//
//  HHWindowView.h
//  UISwitch
//
//  Created by HHL on 16/7/14.
//  Copyright © 2016年 LXH. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^DownLoadBlock) ();

@interface HHWindowView : UIView <UIDynamicAnimatorDelegate>
@property (nonatomic , strong) UIDynamicAnimator *animator;//物理仿真动画
@property (nonatomic, assign) CGPoint startPoint;//触摸起始点
@property (nonatomic, assign) CGPoint endPoint;//触摸结束点
@property (nonatomic,   copy) DownLoadBlock downLoadBlock;
@property (nonatomic , strong) UIView *backgroundView;//背景视图
@property (nonatomic , strong) UIView * imageBackgroundView;

@property (nonatomic , strong) UIImageView *imageView;//图片视图

+ (HHWindowView*)shareView;
//- (void)show;
@end
