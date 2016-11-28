//
//  HHNSStringVC.m
//  HHSummarize
//
//  Created by LXH on 2016/11/22.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHNSStringVC.h"

@interface HHNSStringVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
}
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation HHNSStringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [NSMutableArray array];
    [self config];
    [self string];
}

- (void)config
{
    self.navigationItem.title = @"NSString";
    [self.view addSubview:self.myTableView];
}

- (void)string
{
    int number = -3;
    
    //取绝对值()
    NSString *absString = [NSString stringWithFormat:@"求整数%i的绝对值：%i",number,abs(number)];
    
    CGFloat flt0 = -3.14;
    CGFloat flt1 = 5.57;
    
    //floorl() 向下取整
    NSString *floorfString = [NSString stringWithFormat:@"求浮点型%0.2f取整：%d",flt0,(int)flt0];;
    NSString *floorfString1 = [NSString stringWithFormat:@"求浮点型%0.2f向下取整：%d",flt0,(int)floorl(flt0)];;
    
    //ceilf() 向上取整
    NSString *ceilfString = [NSString stringWithFormat:@"求浮点型%0.2f取整：%d",flt1,(int)flt1];;
    NSString *ceilfString1 = [NSString stringWithFormat:@"求浮点型%0.2f向上取整：%d",flt1,(int)ceilf(flt1)];
    
    //round() 四舍五入
    NSString *roundString = [NSString stringWithFormat:@"求浮点型%0.2f四舍五入值：%0.2f",flt0,round(flt0)];;
    NSString *roundString1 = [NSString stringWithFormat:@"求浮点型%0.2f四舍五入值：%0.2f",flt1,round(flt1)];
    
    //fmaxf() 两个数的最大值
    
    NSString *fmax = [NSString stringWithFormat:@"%0.2f 和 %0.2f中得最大值：%0.2f",flt0,flt1,fmaxf(flt0,flt1)];
    
    //fmin() 两个数的最小值
    
    NSString *fmin = [NSString stringWithFormat:@"%0.2f 和 %0.2f中得最小值：%0.2f",flt0,flt1,fminf(flt0,flt1)];
    
    //fmod() 两个数相除后的余数
    
    CGFloat m = 10.1;
    CGFloat n = 3.f;
    
    NSString *fmod = [NSString stringWithFormat:@"%0.2f 和 %0.2f相除后的余数：%0.2f",m,n,fmodf(m,n)];

    //modf /modff() /modfl
    
    float a;
    float c;
    float b = 8.22;
    a = modff(b, &c);
    NSString *modf = [NSString stringWithFormat:@"%0.2f的整数部分是：%0.0f 小数部分是：%0.2f",b,c,a];
    
    DLog(@"%@",absString);
    DLog(@"%@",floorfString);
    DLog(@"%@",floorfString1);
    DLog(@"%@",ceilfString);
    DLog(@"%@",ceilfString1);
    DLog(@"%@",roundString);
    DLog(@"%@",roundString1);
    DLog(@"%@",fmax);
    DLog(@"%@",fmin);
    DLog(@"%@",fmod);
    DLog(@"%@",modf);
    [dataArray addObject:absString];
    [dataArray addObject:floorfString];
    [dataArray addObject:floorfString1];
    [dataArray addObject:ceilfString];
    [dataArray addObject:ceilfString1];
    [dataArray addObject:roundString];
    [dataArray addObject:roundString1];
    [dataArray addObject:fmax];
    [dataArray addObject:fmin];
    [dataArray addObject:fmod];
    [dataArray addObject:modf];
    
}













/*--------------------------- UITableView ---------------------------*/
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
    return dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
