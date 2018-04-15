//
//  HHScrollViewVC.m
//  HHSummarize
//
//  Created by Mac on 2018/4/14.
//  Copyright © 2018年 HHL. All rights reserved.
//

#import "HHScrollViewVC.h"

static CGFloat const HHTopViewHeight = 140;

@interface HHScrollViewVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *topView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HHScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addSubview:self.topView];
    
    
    [self.scrollView addSubview:self.myTableView];
    [self.myTableView reloadData];
    self.myTableView.height = self.myTableView.contentSize.height;
    self.scrollView.contentSize = CGSizeMake(0, self.myTableView.bottom);
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, HHTopViewHeight)];
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.image = [UIImage imageNamed:@"0.jpg"];
    }return _imageView;
}
- (UILabel *)topView {
    if (!_topView) {
        _topView = [[UILabel alloc] initWithFrame:CGRectMake(0, HHTopViewHeight, self.view.width, 60)];
        _topView.text = @"我是悬停的工具条";
        _topView.textAlignment = NSTextAlignmentCenter;
        _topView.font = [UIFont systemFontOfSize:32];
        _topView.backgroundColor = [UIColor greenColor];
    }return _topView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.height = self.view.height - 64;
        _scrollView.backgroundColor = [UIColor blueColor];
        _scrollView.contentSize = CGSizeMake(0, 1000);
        _scrollView.delegate = self;
    }return _scrollView;
}
- (UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,HHTopViewHeight + 60,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 100) {
        return 2;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
        cell.textLabel.text = tableView.tag - 100?@"我是一只小小鸟": @"小小的身体大大的梦想";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        CGFloat positonY = scrollView.contentOffset.y;
        if (positonY >= HHTopViewHeight) {
            self.topView.y = 0;
            [self.view addSubview:self.topView];
        }else {
            self.topView.y = HHTopViewHeight;
            [self.scrollView addSubview:self.topView];
        }
        
        CGFloat scale = 1 -(positonY / 80);
        scale = scale > 1 ? scale : 1;
        self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
        
        //为了让imageView 相对于scrollview的y坐标的位置不变动
        self.imageView.y = positonY;
        
        NSLog(@"%f",positonY);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
}
@end
