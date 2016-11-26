//
//  HHNSStringVC.m
//  HHSummarize
//
//  Created by LXH on 2016/11/22.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHNSStringVC.h"

@interface HHNSStringVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation HHNSStringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
}

- (void)config
{
    self.navigationItem.title = @"NSString";
    [self.view addSubview:self.myTableView];
}

- (void)string
{
    int number = -3;
    
    NSString *absString = [NSString stringWithFormat:@"求整数%i的绝对值：--%i",number,abs(number)];
    
    CGFloat flt0 = -3.14;
    CGFloat flt1 = 5.57;
    NSString *floorfString = [NSString stringWithFormat:@"求浮点型%0.2f取整：--%d",flt0,(int)flt0];;
    NSString *floorfString1 = [NSString stringWithFormat:@"求浮点型%0.2f向下取整：--%d",flt0,(int)floorf(flt0)];;
    
    NSString *ceilfString = [NSString stringWithFormat:@"求浮点型%0.2f取整：--%d",flt0,(int)flt1];;
    NSString *ceilfString1 = [NSString stringWithFormat:@"求浮点型%0.2f向下取整：--%d",flt0,(int)floorf(flt1)];;
    
}













/*--------------------------- UITableView ---------------------------*/
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
    return 1;
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
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
