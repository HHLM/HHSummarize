//
//  HHNSArrayVC.m
//  HHSummarize
//
//  Created by Mac on 2018/4/25.
//  Copyright © 2018年 HHL. All rights reserved.
//

#import "HHNSArrayVC.h"

@interface HHNSArrayVC ()

@end

@implementation HHNSArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"结果1：%@",[self sumNumberA:99999999999999 numberB:10]);
    NSLog(@"结果2：%@",[self bigSumWithNumberA:999999999999999999 numberB:100000000000000]);
}

/**
 适用于一个是超大数 另一个不是超大数
 */
- (NSString *)sumNumberA:(long long)numberA numberB:(int)numberB
{
    NSString *number1 = @(numberA).description;
    NSMutableArray *datas = [NSMutableArray array];
    int b = numberB;
    for (NSInteger i = (number1.length -1); i >= 0; i--) {
        char a = [number1 characterAtIndex:i];
        NSInteger num = [[NSString stringWithFormat:@"%c",a] integerValue];
        [datas addObject:@(num * b).description];
    }
    
    for (int i = 0; i < datas.count-1; i++) {
        
        NSInteger temp = [datas[i] integerValue]/10;
        datas[i] = @([[datas objectAtIndex:i] integerValue] %10).description;
        datas[i+1] = @([datas[i+1] intValue] + temp).description;
    }
    //数组逆序
    datas = (NSMutableArray *)[[datas reverseObjectEnumerator] allObjects];
    
    NSString *bigNumber = [datas componentsJoinedByString:@""];
    
    NSLog(@"%@",bigNumber);
    return bigNumber;
}
/**
 适用于两个都是超大数
 */
- (NSString *)bigSumWithNumberA:(long long)numberA numberB:(long long)numberB
{
    
    
    NSString *number1 =@(numberA).description;
    NSString *number2 = @(numberB).description;
    
    
    NSMutableArray *dataAll = [NSMutableArray array];
    
    
    for (NSInteger j = number2.length -1; j >= 0; j --) {
        
        unichar nStr = [number2 characterAtIndex:j];
        
        int b = [[NSString stringWithFormat:@"%c",nStr] intValue];
        
        NSMutableArray *datas = [NSMutableArray array];
        for (NSInteger i = (number1.length -1); i >= 0; i--) {
            char a = [number1 characterAtIndex:i];
            NSInteger num = [[NSString stringWithFormat:@"%c",a] integerValue];
            [datas addObject:@(num * b).description];
        }
        NSLog(@"%@",datas);
        
        for (int i = 0; i < datas.count-1; i++) {
            
            NSInteger temp = [datas[i] integerValue]/10;
            datas[i] = @([[datas objectAtIndex:i] integerValue] %10).description;
            datas[i+1] = @([datas[i+1] intValue] + temp).description;
        }
        [dataAll addObject:datas];
    }
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i< dataAll.count; i ++) {
        NSArray *datas = dataAll[i];
        for (int j = 0; j < datas.count; j ++) {
            if (array.count <= i+j) {
                [array addObject:datas[j]];
            }else {
                NSString *temp = @([array[i+j] integerValue] + [datas[j] integerValue] ).description;
                array[i+j] = temp;
            }
        }
    }
    NSLog(@"------:%@",array);
    
    
    for (int i = 0; i < array.count-1; i++) {
        
        NSInteger temp = [array[i] integerValue]/10;
        array[i] = @([[array objectAtIndex:i] integerValue] %10).description;
        array[i+1] = @([array[i+1] intValue] + temp).description;
    }
    
    NSLog(@"%@",array);
    array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
    
    NSString *bigNumber = [array componentsJoinedByString:@""];
    
    NSLog(@"%@",array);
    NSLog(@"%@",bigNumber);
    return bigNumber;
    
}


@end
