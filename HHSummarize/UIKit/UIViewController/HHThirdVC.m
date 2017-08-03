//
//  HHThirdVC.m
//  HHSummarize
//
//  Created by LXH on 2016/12/14.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHThirdVC.h"

@interface HHThirdVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titlesArray;
}
@property (nonatomic, strong) UITableView       *myTableView;

@property (nonatomic, strong) NSMutableArray    *dataArray;

@end

@implementation HHThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    [self.view addSubview:self.myTableView];
}
- (void)config
{
     self.navigationItem.title = @"工具类界面";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;    
    
    [self.dataArray setArray: @[@"CountDownTime",
                                @"ColumnView",
                                @"Circulate",
                                @"PhotoView",
                                @"PickerView",
                                @"TTSSpeak"]];
    
    titlesArray = @[@"倒计时cell",
                    @"仿网易新闻的选择item",
                    @"scrollView轮播图",
                    @"添加图片",
                    @"地址选择器",
                    @"语音播报"];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titlesArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = titlesArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [self.dataArray objectAtIndex:indexPath.row];
    name = [@"HH" stringByAppendingString:name];
    name = [name stringByAppendingString:@"VC"];
    Class class = NSClassFromString(name);
    HHBaseVC *vc = [[class alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
