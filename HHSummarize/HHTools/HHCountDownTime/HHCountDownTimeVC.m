//
//  HHCountDownTimeVC.m
//  HHSummarize
//
//  Created by LXH on 2016/12/14.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHCountDownTimeVC.h"
#import "HHTimeCell.h"

#define kScreenWidth self.view.frame.size.width

#define kScreenHeight self.view.frame.size.height
#define TABLE_COUNT 2
#define TOP     60

@interface HHCountDownTimeVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISegmentedControl  *segment;
@property (nonatomic, strong) NSArray *dateArray1,*dateArray2;

@end

@implementation HHCountDownTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    [self config];
}
- (void)config
{
    self.dateArray1 = @[@"1489699203",
                        @"1489698203",
                        @"1489797203",
                        @"1489717203",
                        @"1489727203",
                        @"1489737203"];
    self.dateArray2 = @[@"1489747203",
                        @"1489877203",
                        @"1469817203",
                        @"1469737203",
                        @"1489907203",
                        @"1469797203"];
    [self.view addSubview:self.segment];
    [self.view addSubview:self.scrollView];
    [self creatUI];
}
- (void)creatUI
{
    for (int i = 0; i < TABLE_COUNT; i++)
    {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight-(TOP - 20))];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tableView.tag = TOP + i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [tableView   setSeparatorColor:[UIColor    groupTableViewBackgroundColor]];
        [self.scrollView addSubview:tableView];
        [self.scrollView setContentSize:CGSizeMake(kScreenWidth *2, 0)];
        
    }
    
    
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-TOP)];
    }
    return _scrollView;
}
- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"报名",@"赚取"]];;
        [_segment setFrame:CGRectMake(0, 20, kScreenWidth, TOP-20)];
        [_segment addTarget:self action:@selector(hhh:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}
- (void)hhh:(UISegmentedControl *)sender
{
    self.scrollView.contentOffset = CGPointMake(sender.selectedSegmentIndex * kScreenWidth, 0);
    UITableView *tableView = [self.view viewWithTag:TOP + sender.selectedSegmentIndex];
    [tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == TOP) {
        return self.dateArray1.count;
    }
    return self.dateArray2.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHTimeCell *cell = [HHTimeCell creatCellWithTabelView:tableView];
    if (tableView.tag == TOP) {
        //        cell.textLabel.text = self.dateArray1[indexPath.row];
        [cell refershCell:self.dateArray1[indexPath.row] type:TimeEndType];
    }
    else {
        [cell refershCell:self.dateArray2[indexPath.row] type:TimeBeginType];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
