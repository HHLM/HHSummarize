//
//  HHTableViewVC.m
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHUITableViewVC.h"
#import "HHTableViewController.h"
#import "HHViewController.h"

@interface HHUITableViewVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation HHUITableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.btn];
    self.btn.hidden = YES;
//    self.navigationController.navigationBar.translucent = YES;
}
- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-80, HHEIGHT-64-80, 60, 60)];
        [_btn setTitle:@"顶部" forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor redColor];
        _btn.layer.cornerRadius = CGRectGetWidth(_btn.frame)/2;
        _btn.clipsToBounds = YES;
        [_btn addTarget:self action:@selector(top) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (void)top{
    [self.myTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
    CGRect rectInTableView = [self.myTableView rectForRowAtIndexPath:path];
    CGRect rect = [self.myTableView convertRect:rectInTableView toView:[self.myTableView superview]];
    //    NSLog(@"++++++%f",rect.origin.y);
    
    if (rect.origin.y < 64) {
        self.btn.hidden = NO;
    }
    else {
        self.btn.hidden = YES;
    }
}
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, HWIDTH, HHEIGHT - 64)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
    //    先计算cell的位置,再转化到view中的位置.
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    NSLog(@"--------%f",rectInTableView.origin.y);
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    NSLog(@"++++++%f",rect.origin.y);
    if (indexPath.section == 0) {
        HHViewController *vc = [[HHViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        HHTableViewController *vc = [[HHTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHH"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HHH"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"HHLM";
    }else {
        cell.textLabel.text = @"你就是个傻瓜";
    }
    
    return cell;
}

@end
