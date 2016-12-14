//
//  HHTimeCell.m
//  HHCountDownTime
//
//  Created by LXH on 16/7/28.
//  Copyright © 2016年 LXH. All rights reserved.
//

#import "HHTimeCell.h"

@implementation HHTimeCell
{
    dispatch_source_t _timer;
    TimeType          _type;
}


- (void)refershCell:(NSString *)timeString type:(TimeType)type
{
    _type = type;
    //获取时间戳
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSInteger time = [timeString integerValue] - [timeSp integerValue];
    [self startTime:time];
}
+ (instancetype)creatCellWithTabelView:(UITableView *)tabelView {
    HHTimeCell *cell = [tabelView dequeueReusableCellWithIdentifier:NSStringFromClass([HHTimeCell class])];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HHTimeCell class]) owner:self options:nil] firstObject];
    }
    return cell;
}
-(void)startTime:(NSInteger )timeString
{
    __block long int timeCount = timeString;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时回调方法
        [self dateRepeat:timeCount];
         timeCount -- ;
    });
    dispatch_resume(_timer);
}
- (void)dateRepeat:(NSInteger )timeString
{
    
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^(){
       
        NSString *string = [self timeFormatted:timeString];
        
        dispatch_async(dispatch_get_main_queue(), ^(){

            self.lab.text = [NSString stringWithFormat:@"%@",string];
        });
    });

}
- (NSString *)timeFormatted:(long)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    long hours = totalSeconds / 3600;
    
    if (_type == TimeEndType) {
        if (seconds < 0){
            return  @"已结束";
        }
        else{
            return [NSString stringWithFormat:@"距结束:%02ld:%02d:%02d",hours, minutes, seconds];
        }
        
    } else {
        if (seconds < 0){
            return  @"已开始";
        }
        else{
            return [NSString stringWithFormat:@"距开始:%02ld:%02d:%02d",hours, minutes, seconds];
        }
    }
    
}
@end
