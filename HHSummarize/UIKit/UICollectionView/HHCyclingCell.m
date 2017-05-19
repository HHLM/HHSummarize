//
//  HHCyclingCell.m
//  HHSummarize
//
//  Created by LXH on 2016/11/29.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHCyclingCell.h"

@implementation HHCyclingCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.imgView];
        [self addSubview:self.titleLab];
    }
    return self;
}
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgView.backgroundColor = [UIColor greenColor];
    }
    return _imgView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 20, self.width, 20)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
//        _titleLab.text = @"headView";
        _titleLab.textColor = [UIColor redColor];
//        _titleLab.backgroundColor = [UIColor greenColor];
    }
    return _titleLab;
}
@end
