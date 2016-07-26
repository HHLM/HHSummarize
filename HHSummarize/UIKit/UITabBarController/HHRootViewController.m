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
    
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:1];
    
    item1.title = @"UIKit";
    item2.title = @"Foundation";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
