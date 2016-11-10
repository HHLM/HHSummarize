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
@interface HHSecondVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView       *myTableView;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@end



@implementation HHSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Foundation界面";
    [self.view addSubview:self.myTableView];
    NSDate*date = [HHUnit dateFormDateString:@"2016-09-10 12:12:12" formate:@"yyyy-MM-dd hh:mm:ss"];
    [NSDate timeInfoWithDate:date];
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
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
