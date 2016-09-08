//
//  HHFirstVC.m
//  HHSummarize
//
//  Created by LXH on 16/7/26.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHFirstVC.h"
#import "HHUILabelVC.h"
#import "HHUIButtonVC.h"
#import "HHUIWebViewVC.h"
#import "HHUITableViewVC.h"
@interface HHFirstVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HHFirstVC


/**
 1.info.plist文件中添加一项:Fonts provided by application 并添加字体库名字 xxx.ttf
 2.前往TARGETS -> Build Phases -> Copy Bundle Resources中添加字体文件
 3.按照fontName方法遍历找到对应的字体
 4.使用字体 [UIFont fontWithName:@"FZYaSong-M-GBK" size:17];
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"UI界面";
    [self config];
    [self.view addSubview:self.tableView];
    
}
- (void)config
{
    self.dataArray = @[@"UILabel",@"UIButton",@"UIImageView",@"UIFont",@"UIWebView",@"UITableView"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = [self.dataArray objectAtIndex:indexPath.row];
    name = [@"HH" stringByAppendingString:name];
    name = [name stringByAppendingString:@"VC"];
    Class class = NSClassFromString(name);
    HHBaseVC *vc = [[class alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView =[[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
