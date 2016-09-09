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
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor cyanColor]}];
    
    //导航条染色
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    
    //导航条是否透明
    [UINavigationBar appearance].translucent = NO;
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar"] forBarMetrics:UIBarMetricsDefaultPrompt];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar"] forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefaultPrompt];;
//    
    /*----------------------------分割线-------------------------------------*/
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:1];
    
    item1.title = @"UIKit";
    item2.title = @"Foundation";
    
    
    item1.image = [UIImage imageNamed:@"home"];
    item1.selectedImage = [UIImage imageNamed:@"home_selected"];
    item2.image = [UIImage imageNamed:@"maps"];
    item2.selectedImage = [UIImage imageNamed:@"maps_selected"];
    //item选中染色
    [[UITabBar appearance] setTintColor:[UIColor greenColor]];

//UITabBar的背景颜色
    UIImage *barBackground = [UIImage imageNamed:@"tabbar"];
    [[UITabBar appearance] setBackgroundImage:barBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected"]];

    
#if 0
    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    /**
     字体颜色 字体大小
     */
    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15],NSBackgroundColorAttributeName:[UIColor yellowColor]} forState:UIControlStateNormal];
    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor greenColor]} forState:UIControlStateSelected];
#else
    //设置item的字体颜色 大小等等
    
    self.tabBar.translucent = NO;
    
    NSDictionary *info = @{NSForegroundColorAttributeName :[UIColor redColor],
                           NSFontAttributeName:[UIFont systemFontOfSize:15],
                           NSBackgroundColorAttributeName:[UIColor yellowColor]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:info forState:UIControlStateNormal];
    
#endif

    
    /*--------------------可以添加背景颜色的View--------------*/
    UIView *bgView =[[UIView alloc]initWithFrame:self.tabBar.bounds];//这是整个tabbar的颜色
    
    [bgView setBackgroundColor:[UIColor blueColor]];
    
    [self.tabBar insertSubview:bgView atIndex:0];
    bgView.alpha = 0.8;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
