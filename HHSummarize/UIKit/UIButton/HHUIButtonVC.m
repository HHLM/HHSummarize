
//
//  HHUIButtonVC.m
//  HHSummarize
//
//  Created by LXH on 16/7/29.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHUIButtonVC.h"
#import "HHTimeButton.h"
#import "UIView+EXT.h"
#import "UIView+Animation.h"
@interface HHUIButtonVC ()
@property (weak, nonatomic) IBOutlet UIButton *button1;

@end

@implementation HHUIButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"VC" withString:@""];
    [self.button1 addTarget:self action:@selector(UpInside) forControlEvents:UIControlEventTouchUpInside];
    self.button1.backgroundColor = [UIColor redColor];
    [self.button1 addTarget:self action:@selector(DragOutside) forControlEvents:UIControlEventTouchDragOutside];
    [self.button1 addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
    [self.button1 addTarget:self action:@selector(UpOutside) forControlEvents:UIControlEventTouchUpOutside];
    
    HHTimeButton *timeBtn = [[HHTimeButton alloc] initWithFrame:CGRectMake(10,200 , 100, 40)];
    [timeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [timeBtn addBorderLine:HHBorderTop borderColor:[UIColor yellowColor] borderWidth:2];
    [timeBtn addBorderLine:HHBorderLeft borderColor:[UIColor redColor] borderWidth:2];

    [timeBtn shakeHorizontally];
    
    timeBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:timeBtn];
    [timeBtn addTouchDownBlock:^NSString *(HHTimeButton *touchBtn, int tag) {
        
      return @"18576757855";
    }];
    
}
- (void)UpInside
{
    self.label.text = @"发送成功";
}
- (void)DragOutside
{
    self.label.text = @"正在录音 松开取消录音";
}
- (void)TouchDown
{
    self.label.text = @"开始录音 向下滑动可以取消";
}
- (void)UpOutside
{
    self.label.text = @"已经取消录音";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
