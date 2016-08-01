//
//  HHTimeButton.h
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHTimeButton;

typedef NSString    *(^HHDidChangeBlock)(HHTimeButton *touchBtn,int second); //带返回参数的block
typedef NSString    *(^HHFinishedBlock)(HHTimeButton *touchBtn,int second);
typedef NSString    *(^HHTouchDownBlock)(HHTimeButton *touchBtn,int tag);

@interface HHTimeButton : UIButton
{
    int         _second; //总时间
    int         _totalSecond; //总时间
    NSTimer     *_timer;
    NSDate      *_startDate; //开始时间
    HHDidChangeBlock    didChangeBlock;
    HHFinishedBlock     finishedBlock;
    HHTouchDownBlock block;
}
- (void)addTouchDownBlock:(HHTouchDownBlock)touchDownBlock;

@end
