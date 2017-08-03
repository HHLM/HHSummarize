//
//  HHTTSSpeakVC.m
//  HHSummarize
//
//  Created by LXH on 2017/8/3.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "HHTTSSpeakVC.h"
#import "HHTTSModel.h"
@interface HHTTSSpeakVC ()
@property (nonatomic, strong) UIButton *left;
@property (nonatomic, strong) UIButton *right;
@property (nonatomic, strong) UIButton *middle;
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) HHTTSModel *ttsSpeak;
@end

@implementation HHTTSSpeakVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.left];
    [self.view addSubview:self.middle];
    [self.view addSubview:self.right];
    [self.view addSubview:self.lable];
}
- (HHTTSModel *)ttsSpeak {
    if (!_ttsSpeak) {
        _ttsSpeak = [[HHTTSModel alloc] init];
    }return _ttsSpeak;
}
- (void)clicked:(UIButton *)btn {
    if (btn.tag == 0) {
        //若是结束 或者暂停状态 就开始播放
        if (self.ttsSpeak.pause|| self.ttsSpeak.stop) {
            [self.ttsSpeak ttstar];
        }else {
            //若是第一次播放
            [self.ttsSpeak speaking:self.lable.text];
        }
    }else if (btn.tag == 1) {
        [self.ttsSpeak ttpause];
    }else if (btn.tag == 2) {
        [self.ttsSpeak ttstop];
    }
}

#pragma mark -- creat UI
- (UILabel *)lable {
    if (!_lable) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 400)];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.numberOfLines = 0;
        _lable.font = [UIFont systemFontOfSize:25];
        _lable.text = @"床前明月光，\n地上鞋两双，\n我是小萝卜，\n有点心慌慌。";
    }return _lable;
}
- (UIButton *)left {
    if (!_left) {
        _left = [UIButton buttonWithType:UIButtonTypeCustom];
        [_left setFrame: CGRectMake(0, 100, CGRectGetWidth(self.view.frame)/3, 44)];
        [_left setTitle:@"播放" forState:UIControlStateNormal];
        _left.tag = 0;
        [_left setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_left addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _left;
}
- (UIButton *)middle {
    if (!_middle) {
        _middle = [UIButton buttonWithType:UIButtonTypeCustom];
        [_middle setFrame: CGRectMake(CGRectGetWidth(self.view.frame)/3, 100, CGRectGetWidth(self.view.frame)/3, 44)];
        [_middle setTitle:@"暂停" forState:UIControlStateNormal];
        _middle.tag = 1;
        [_middle setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_middle addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _middle;
}
- (UIButton *)right {
    if (!_right) {
        _right = [UIButton buttonWithType:UIButtonTypeCustom];
        [_right setFrame: CGRectMake(CGRectGetWidth(self.view.frame)/3 * 2, 100, CGRectGetWidth(self.view.frame)/3, 44)];
        [_right setTitle:@"结束" forState:UIControlStateNormal];
        _right.tag = 2;
        [_right setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_right addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _right;
}


@end
