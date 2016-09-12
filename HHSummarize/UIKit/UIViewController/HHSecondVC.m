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
@interface HHSecondVC ()

@end



@implementation HHSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Foundation界面";
    NSDate*date = [HHUnit dateFormDateString:@"2016-09-10 12:12:12" formate:@"yyyy-MM-dd hh:mm:ss"];
    [NSDate timeInfoWithDate:date];
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
