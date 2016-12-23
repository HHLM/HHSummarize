//
//  HHColumnViewVC.m
//  HHSummarize
//
//  Created by LXH on 2016/12/14.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHColumnViewVC.h"

#import "HHColumnView.h"
@interface HHColumnViewVC ()<HHColumnViewDelegate>

@end

@implementation HHColumnViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    HHColumnView *columnView = [[HHColumnView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45) styleType:HHColumnRoundType];
    columnView.columnDelegate = self;
    [self.view addSubview:columnView];
    columnView.columnArray = @[@"HHLM",@"你知道你",@"HHLM",@"你知道什么",@"你什么",@"你知道你的在左什么",@"HHLM",@"你",@"HHLM",@"什么",@"你知什么",@"你知在左什么"];
}
- (void)columunViewSelectItem:(NSInteger)item {
    DLog(@"点击%ld",item);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
