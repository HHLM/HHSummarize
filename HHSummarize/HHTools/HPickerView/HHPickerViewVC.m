//
//  HHPickerViewVC.m
//  HHSummarize
//
//  Created by LXH on 2017/6/23.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "HHPickerViewVC.h"
#import "HHCustomPickerView.h"
#import "HHAddressModel.h"

@interface HHPickerViewVC ()<HHPickerViewDelegate>
{
    UILabel *lab;
}
@property (nonatomic, strong) HHCustomPickerView *pickerView;
@end

@implementation HHPickerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 40)];
    lab.textColor = [UIColor purpleColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:24];
    lab.text = @"点我有奇迹发生~~~";
    [self.view addSubview:lab];
}
- (void)pickerViewSelectString:(NSString *)string {
    lab.text = string;
}
- (HHCustomPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[HHCustomPickerView alloc] initWithFrame:self.view.bounds showView:self.view];
        _pickerView.delegate = self;
    }return _pickerView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.pickerView showPickerView:HHPickerAddrssType];
}
- (void)dealloc {
    [self.pickerView removeFromSuperview];
    self.pickerView = nil;
    NSLog(@"%@",_pickerView);
}

@end
