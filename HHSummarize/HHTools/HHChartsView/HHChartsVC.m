//
//  HHChartsVC.m
//  HHSummarize
//
//  Created by LXH on 2017/9/27.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "HHChartsVC.h"
#import "HHDreawView.h"
@interface HHChartsVC ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HHDreawView *drawView;
@end

@implementation HHChartsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray array];
    [_dataArray addObjectsFromArray:@[@[@"20",@"200"],
                                      @[@"80",@"300"],
                                      @[@"140",@"450"],
                                      @[@"180",@"500"],
                                      @[@"220",@"400"],
                                      @[@"260",@"350"],
                                      @[@"300",@"200"]]];
    [self.view addSubview:self.drawView];
    self.drawView.dataArray = _dataArray;
}



- (HHDreawView *)drawView {
    if (!_drawView) {
        _drawView = [[HHDreawView alloc] initWithFrame:self.view.frame];
        _drawView.backgroundColor = [UIColor whiteColor];
    }return _drawView;
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
