//
//  HHRootViewController.m
//  HHSummarize
//
//  Created by LXH on 16/7/26.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHRootViewController.h"
#import "HHFirstVC.h"
#import "HHSecondVC.h"
@interface HHRootViewController ()

@end

@implementation HHRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HHFirstVC  *first   = [[HHFirstVC alloc] init];
    HHSecondVC *second  = [[HHSecondVC alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:first];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:second];
    self.viewControllers = @[nav1,nav2];
    
    //设置导航的文字颜色 和背景颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor greenColor]}];
    
    //导航条染色
    [UINavigationBar appearance].barTintColor = [UIColor redColor];
    
    //导航条是否透明
    [UINavigationBar appearance].translucent = NO;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar"] forBarMetrics:UIBarMetricsDefaultPrompt];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar"] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefaultPrompt];;
    
    /*----------------------------分割线-------------------------------------*/
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:1];
    
    item1.title = @"UIKit";
    item2.title = @"Foundation";
    item1.image = [UIImage imageNamed:@"home"];
    item1.selectedImage = [UIImage imageNamed:@"home_selected"];
    item2.image = [UIImage imageNamed:@"maps"];
    item2.selectedImage = [UIImage imageNamed:@"maps_selected"];
//UITabBar的背景颜色
//    UIImage *barBackground = [UIImage imageNamed:@"tabbar"];
//    [[UITabBar appearance] setBackgroundImage:barBackground];
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected"]];

//    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
//    /**
//     字体颜色 字体大小
//     */
//    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15],NSBackgroundColorAttributeName:[UIColor yellowColor]} forState:UIControlStateNormal];
//    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
//    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor greenColor]} forState:UIControlStateSelected];
    
    //设置item的字体颜色 大小等等
    
//    [UITabBar appearance].barStyle = UIBarStyleBlackTranslucent;
    self.tabBar.translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName :[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15],NSBackgroundColorAttributeName:[UIColor yellowColor]} forState:UIControlStateNormal];
    
    //上面写法默认图片的颜色是系统的蓝色 下面的代码是改变图片的颜色
//    self.tabBar.tintColor = [UIColor yellowColor];
    [[UITabBar appearance] setTintColor:[UIColor greenColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
