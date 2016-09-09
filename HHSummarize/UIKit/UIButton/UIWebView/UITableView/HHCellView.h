//
//  HHCellView.h
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHModel.h"
@interface HHCellView : UIControl
@property (nonatomic, retain) UIImageView           *photoView;
@property (nonatomic, retain) UILabel               *titleLabel;
@property (nonatomic, retain) UILabel               *numberLabel;
@property (nonatomic, retain) UIButton              *deletaBtn;
@property (nonatomic, assign,readonly) CGFloat heigh;
- (void)model:(HHModel*)model;
@end
