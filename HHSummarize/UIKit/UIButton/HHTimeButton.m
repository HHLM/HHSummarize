//
//  HHTimeButton.m
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHTimeButton.h"

@implementation HHTimeButton

- (void)addTouchDownBlock:(HHTouchDownBlock)touchDownBlock
{
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    self.backgroundColor = [UIColor blueColor];
    block = [touchDownBlock copy];
    [self addTarget:self
             action:@selector(touched:)
   forControlEvents:UIControlEventTouchUpInside];
}
- (void)touched:(UIButton *)btn
{
    [self startWithSecond:10];
}
#pragma -mark count down method
-(void)startWithSecond:(int)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    _startDate = [NSDate date]; //开始时间
    
    NSString *phone = block(self,1);
    DLog(@"%@",phone);
    
    NSString *title = [NSString stringWithFormat:@"%d秒",_second];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateDisabled];
    self.backgroundColor = [UIColor greenColor];
    self.enabled = NO;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerStart:(NSTimer *)timer
{
    //过了多少秒
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _second = _totalSecond - (int)(deltaTime+0.5) ;
    
    if (_second< 0.0){
        [self stop];
    }
    else
    {
        NSString *title = [NSString stringWithFormat:@"%d秒",_second];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateDisabled];
    }

}
- (void)stop
{
    if (_timer)
    {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _timer = nil;
                _second = _totalSecond;
                self.enabled = YES;
                self.backgroundColor = [UIColor blueColor];
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                
            }
        }
    }
}
@end
