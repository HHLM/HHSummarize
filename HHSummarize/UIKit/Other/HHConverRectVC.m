//
//  HHConverRectVC.m
//  HHShowView
//
//  Created by LXH on 2016/11/9.
//  Copyright © 2016年 LXH. All rights reserved.
//

#import "HHConverRectVC.h"

@interface HHConverRectVC ()

@end

@implementation HHConverRectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 180, 100, 100)];
    view2.backgroundColor = [UIColor greenColor];
    [view1 addSubview:view2];
    
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(100, 380, 100, 100)];
    view3.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view3];
    
    
    /*--------------------------- keywindow 和 self.view.window区别---------------------------*/
    
    
    /**
     self.view.window 只是当前view的window，可能是keyWindow。
     keyWindow是指定的用来接收键盘以及非触摸类的消息，而且程序中每一个时刻只能有一个window是keyWindow。
     */
    
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    
    
    
    //红色view1 中的 绿色view2 相对self.view的坐标
    CGRect rect = [self.view convertRect:view2.frame fromView:view1];
    
     NSLog(@"rect:%@",NSStringFromCGRect(rect));
    
    //红色view1中，定义一个绿色view2，这个绿色view2相对于self.view的位置
    CGRect rect1 = [view1 convertRect:view2.frame toView:self.view];
    
    NSLog(@"rect1:%@",NSStringFromCGRect(rect1));
    
    
    /*--------------------------- 上面俩用法是一样的 ---------------------------*/
    
    //在view3中，有个和view3一样的大小的区域bounds，此区域相对于window的位置
    CGRect rect2 = [view3 convertRect:view3.bounds toView:self.view];
    
    NSLog(@"rect2:%@",NSStringFromCGRect(rect2));
    
    //在view3中，有个和view3一样的大小的区域frame，此区域相对于window的位置
    CGRect rect3 = [view3 convertRect:view3.frame toView:self.view.window];
    

    
    NSLog(@"rect3:%@",NSStringFromCGRect(rect3));
    
    
    
    /*--------------------------- point ---------------------------*/
    CGPoint point = [view1 convertPoint:CGPointMake(100, 180) toView:window];
    NSLog(@"point:%@",NSStringFromCGPoint(point));
    
    CGPoint point1 = [self.view convertPoint:CGPointMake(100, 180) fromView:view1];
    NSLog(@"point1:%@",NSStringFromCGPoint(point1));
    
    CGPoint point2 = [view2 convertPoint:CGPointMake(0, 0) toView:self.view];
    NSLog(@"point2:%@",NSStringFromCGPoint(point2));
    
    
    [self.view.window isKeyWindow];
    
    CGRect rect4=[view2 convertRect: view2.bounds toView:self.view.window];
    NSLog(@"rect4:%@",NSStringFromCGRect(rect4));
    
    /**
     总结：
     toView就是从左往右开始读代码，也是从左往右理解意思
     
     fromView就是从右往左开始读代码，也是从右往左理解意思
     
     - A (CGPoint)convertPoint: B (CGPoint)point toView: C (nullable UIView *)view;
     - A (CGPoint)convertPoint: B (CGPoint)point fromView: C (nullable UIView *)view;
     
     第一句代表
     A区域里面有个坐标B,需要把相对于A的坐标B转换成相对于C的坐标
     
     第二句代表
     从C区域里面转换坐标B，需要把相对于C的坐标转换成相对于A的坐标
     */
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
