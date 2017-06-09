//
//  HHCyclicCell.m
//  HHSummarize
//
//  Created by LXH on 2017/6/9.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "HHCyclicCell.h"

@implementation HHCyclicCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
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
        _titleLab.textColor = [UIColor redColor];
    }
    return _titleLab;
}

@end
