//
//  HHCopyLabel.h
//  HHSummarize
//
//  Created by HHL on 16/7/29.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHCopyLabel : UILabel
@property(nonatomic, assign) BOOL       clickCopy;          //点击复制，如果没设置或为NO，则默认为长按复制
@property (nonatomic,strong) UIColor    *normalColor;       //默认颜色
@property(nonatomic, strong) UIColor    *highLightColor;    //高亮颜色
@end
