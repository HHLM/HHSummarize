//
//  HHUILabelVC.m
//  HHSummarize
//
//  Created by LXH on 16/7/27.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHUILabelVC.h"

@interface HHUILabelVC ()

@end

@implementation HHUILabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 20)];
    lable.text = @"HHLM";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:16];
    lable.textColor = [UIColor greenColor];
    lable.shadowColor = [UIColor redColor];
    lable.shadowOffset = CGSizeMake(100, 10);
    [self.view addSubview:lable];
//    lable.font = [UIFont fontWithName:@"字体名称" size:15];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
