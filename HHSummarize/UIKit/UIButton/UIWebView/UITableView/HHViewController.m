//
//  HHViewController.m
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHViewController.h"
#import "HHTableViewController.h"
#import "HHCell.h"
#import "HHModel.h"
@interface HHViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView     *tabView;
    NSMutableArray  *dataArray;
    NSMutableArray  *dataArray1;
}
@end

@implementation HHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"图片展示";
    dataArray   =   [NSMutableArray array];
    dataArray1  =   [NSMutableArray array];
    
//    self.navigationBarBackgroundHidden = YES; /** < 导航透明 > **/
    
     self.navigationController.navigationBar.barTintColor = [UIColor redColor];/** < 改变导航栏颜色 > **/
    
    
    for (int i = 0; i < 16; i ++)
    {
        HHModel *model = [[HHModel alloc] init];
        model.title    = [NSString stringWithFormat:@"蒂法%d",arc4random()%100];
        model.number   = [NSString stringWithFormat:@"%d",arc4random()%100];
        model.image    = @"11.jpg";
        
        if (i %5 == 1)
        {
            model.title = @"最终幻想";
        }
        [dataArray1 addObject:model];
    }
    
    for (int i = 0; i < 11; i ++)
    {
        HHModel *model = [[HHModel alloc] init];
        model.title    = [NSString stringWithFormat:@"君莫弃%d",arc4random()%100];
        model.number   = [NSString stringWithFormat:@"%d",arc4random()%100];
        model.image    = [NSString stringWithFormat:@"%d.jpg",i];
        
        if (i %3 == 1)
        {
            model.title = @"咫尺天涯";
        }
        [dataArray addObject:model];
    }
    
    
    tabView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, HWIDTH, HHEIGHT - 64)];
    tabView.delegate   = self;
    tabView.dataSource = self;
    [self.view addSubview:tabView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (dataArray1.count%3 == 0)
        {
            return dataArray1.count/3;
        }
        else
        {
            return dataArray1.count/3+1;
        }
    }
    if (dataArray.count%3 == 0)
    {
        return dataArray.count/3;
    }
    else
    {
        return dataArray.count/3+1;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HHCell *cell = (HHCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHight;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HHCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0)
    {
        [cell dataArray:dataArray1 indexPath:indexPath];
    }
    else if(indexPath.section == 1)
    {
        [cell dataArray:dataArray indexPath:indexPath];
    }


    __weak  HHViewController *weak = self;
    
    [cell selectCellView:^(NSInteger index) {
        /** < block回掉> **/
        [weak selectCell:indexPath cellView:index];
    }];
    return cell;
}

- (void)selectCell:(NSIndexPath*)indexPath  cellView:(NSInteger)index
{
    
    HHTableViewController *HHVC = [[HHTableViewController alloc] init];
    [self.navigationController pushViewController:HHVC animated:YES];
    
    NSLog(@"第%ld组--第%ld行Cell--第%ld个cellView",indexPath.section,(long)indexPath.row,(long)index);
    
    NSString *string = [NSString stringWithFormat:@"点击了\n第%ld组\n第%ld行Cell上\n第%ld个cellView",indexPath.section,(long)indexPath.row,(long)index];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:string
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
    
}
@end
