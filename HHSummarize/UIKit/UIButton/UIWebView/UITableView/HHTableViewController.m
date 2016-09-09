//
//  HHTableViewController.h
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHTableViewController.h"

@interface HHTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@end

@implementation HHTableViewController
{
    UISearchDisplayController *Display;
    UITableView *mytableview;
    NSMutableArray *array;
    NSMutableArray *arr;
    UISearchBar *seach;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    array = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        NSString *str = [NSString stringWithFormat:@"0000%d",i];
        [array addObject:str];
    }
    seach = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    Display = [[UISearchDisplayController alloc]initWithSearchBar:seach contentsController:self];
    Display.searchResultsDataSource =self;
    Display.searchResultsDelegate = self;
    
    arr = [[NSMutableArray alloc]init];
    mytableview = [[UITableView alloc ] initWithFrame:CGRectMake(0, 0, HWIDTH, HHEIGHT - 64)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(change:)];
    mytableview.delegate = self;
    mytableview.dataSource = self;
    mytableview.showsVerticalScrollIndicator = NO;
    mytableview.tableHeaderView = seach;
    
    
    
    //cell的分割线颜色为红色
    mytableview.separatorColor = [UIColor redColor];
    //偏移的大小 上／左／下／右
    //mytableview.separatorInset = UIEdgeInsetsMake(100, 100, 0, 100);
    //mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //cell的分割线不显示
    
    //默认选中某一行（0组1行）
    NSIndexPath *ip = [NSIndexPath indexPathForItem:8 inSection:0];
    [mytableview selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    //推到顶部，底部，中间
    [mytableview scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    
    [self.view addSubview:mytableview];
}

//可以编辑cell
-(void)change:(id)sender
{
    BOOL flag;
    flag = mytableview.editing;
    flag = !flag;
    [mytableview setEditing:flag animated:YES];
    NSLog(@"-------------------------------");
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"zhouliu";
//}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIControl *view = [[UIControl alloc] init];
    view.backgroundColor = [UIColor orangeColor];
    [view addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchDragInside];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 40)];
    lable.text = @"Hello,world";
    [view addSubview:lable];
    return view;
}
//能否被移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//交换位置
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [array exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    [mytableview reloadData];
}
//每组多少成员
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mytableview!=tableView)
    {
        [arr removeAllObjects];
        for (NSString *s in array)
        {
            NSRange range = [s rangeOfString:seach.text];
            if (range.length >0 && range.location != NSNotFound)
            {
                NSLog(@"－－－－s = %@",s);
                [arr addObject:s];
            }
        }
        return arr.count;
    }
    return array.count;
}
-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return YES;
}
//允许长按
-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //黏贴板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    
    //获得剪贴板的内容
    [pasteBoard setString:cell.textLabel.text];
    NSLog(@"%@＝＝＝＝",pasteBoard.string);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"拷贝数据"
                                                    message:pasteBoard.string
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
    return YES;
}
//长按后调用的方法
-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    NSLog(@"***************");
}
//索引
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++)
    {
        NSString *s = [NSString stringWithFormat:@"%d",i];
        [a addObject:s];
    }
    return a;
}
//cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //可以避免因复用带来的问题
    
    if (indexPath.row==5)
    {
        static NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            //cell的按钮样式风格
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.textAlignment= NSTextAlignmentCenter;
        
        if (tableView!=mytableview)
        {
            cell.textLabel.text = arr[indexPath.row];
        }
        else
        {
            cell.textLabel.text = array[indexPath.row];
        }
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        return cell;
        
    }
    else
    {
        static NSString *cellID = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            //cell的按钮样式风格
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        
        
        if (tableView!=mytableview)
        {
            cell.textLabel.text = arr[indexPath.row];
        }
        else
        {
            cell.textLabel.text = array[indexPath.row];
        }
        return cell;
        
    }
}
//cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //推到顶部，底部，中间
    [mytableview scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击的是第 %ld 行",indexPath.row);
}
//能否编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//编辑事件
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        [array removeObjectAtIndex:indexPath.row];
        [mytableview reloadData];
    }
    if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        [array addObject:array[indexPath.row]];
        [mytableview reloadData];
        //        [array insertObject:@"新建字符串" atIndex:indexPath.row];
        //2、在tableview中插入一行
        //        [mytableview insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
#pragma mark --   要想滑动删除某一行 把下面的代码注释掉
//设置某一行的编辑状态
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row %2)
    {
        return UITableViewCellEditingStyleDelete;   /** < 删除 > **/
    }
    else
    {
        return UITableViewCellEditingStyleInsert;   /** < 插入 > **/
    }
    return UITableViewCellEditingStyleNone;         /** < 无状态 > **/
}
//改变删除显示的文字
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
