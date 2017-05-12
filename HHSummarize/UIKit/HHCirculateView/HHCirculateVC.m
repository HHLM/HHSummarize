//
//  HHCirculateVC.m
//  HHSummarize
//
//  Created by LXH on 2017/5/11.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "HHCirculateVC.h"
#import "HHCirculateView.h"
@interface HHCirculateVC ()

@end

@implementation HHCirculateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imagesURLStrings = @[
                                  @"http://imgsrc.baidu.com/forum/pic/item/a38e4566d0160924139b6cd9d40735fae7cd342d.jpg",
                                  @"http://www.txjly.com/UploadFiles/jingdian/jpg/2013/8/2013080709574122238.jpg",
                                  @"http://pic32.nipic.com/20130715/13232606_164243348120_2.jpg",
                                  @"http://pic1.nipic.com/2009-02-20/2009220135032130_2.jpg",
                                  @"http://imgsrc.baidu.com/forum/pic/item/7e3e37dfa9ec8a13c6a75501f703918fa1ecc0a0.jpg"
                                  ];
    
   NSMutableArray * array = [NSMutableArray array];
    
    for (int i = 0; i< 6; i++)
    {
        [array addObject:[NSString stringWithFormat:@"%d.jpg",i]];
    }

    
    NSArray *array1 = @[@"洗",
                        @"嘻嘻嘻",
                        @"哈哈哈哈哈哈哈哈",
                        @"wwwwwww",
                        @"呜呜呜呜我问问",
                        @"很好很好很"];

    
    HHCirculateView *cycleView = [[HHCirculateView alloc] initWithFrame:CGRectMake(0, 0,HWIDTH , HHEIGHT/2)];
    
    //回掉函数 点击的几张图片
    [cycleView setBlock:^(NSInteger index) {
       NSLog(@"【cycleView】点击的%ld图片",index);
    }];
    
    [self.view addSubview:cycleView];
    [cycleView setTitleArray:array1];
    [cycleView setTextColor:[UIColor redColor]];
    cycleView.imageArray = array;
    cycleView.autoSroller = YES;
    cycleView.textAliment = HHTextAlignmentLeft;
    


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
