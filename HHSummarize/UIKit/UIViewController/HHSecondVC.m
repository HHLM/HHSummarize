//
//  HHSecondVC.m
//  HHSummarize
//
//  Created by LXH on 16/7/26.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHSecondVC.h"
#import "NSDate+EXT.h"
#import "NSDate+Utilities.h"
#import "HHUnit.h"
#import "HHNSStringVC.h"
@interface HHSecondVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView       *myTableView;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@end



@implementation HHSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Foundation界面";
    [self config];
    

    //{} 执行域 （） 执行
    
    UILabel *labe = ({
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 20)];
        l.text = @"我是label";
        l.textColor = [UIColor greenColor];
        l;
    });
    
    
    [self.view addSubview:self.myTableView];
    NSDate*date = [HHUnit dateFormDateString:@"2016-09-10 12:12:12" formate:@"yyyy-MM-dd hh:mm:ss"];
    [NSDate timeInfoWithDate:date];
    [self.view addSubview:labe];
    UILabel *lll = insertLab();
    [self.view addSubview:lll];
}

UILabel *insertLab() {
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 200, 20)];
    l.text = @"我是label";
    l.textColor = [UIColor redColor];
    return  l;
}

- (void)config
{
    [self.dataArray setArray: @[@"NSString",
                                @"NSArray",
                                @"NSDictionary",
                                @"NSData",
                                @"NSFileManger"]];
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
    return _dataArray.count;
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
    cell.textLabel.text = _dataArray[indexPath.row];
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
