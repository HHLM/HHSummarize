//
//  NSObject+EXT.m
//  HHSummarize
//
//  Created by LXH on 16/7/31.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "NSObject+EXT.h"
#import <objc/runtime.h>
@implementation NSObject (EXT)

- (id)objecWithJsonString:(NSString *)jsonString {
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    id objc = [NSJSONSerialization JSONObjectWithData:data
                                              options:NSJSONReadingMutableLeaves
                                                error:nil];
    return objc;
}

- (NSString *)jsonStringWithObject:(id)object {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}
/**
 *  通过运行时获取
 */
+ (void)logAllIvars {
    // 谁调用这个类方法就传谁
    Class c = self;
    
    while (c) {
        // 获得所有的成员变量
        unsigned int outCount = 0;
        
        Ivar *ivarList = class_copyIvarList(c, &outCount);
        
        // 遍历所有的成员变量
        for (int i = 0; i < outCount; i++) {
            // 获取第i个成员变量
            Ivar ivar = ivarList[i];
            
            // 获得成员变量的名称和类型
           DLog(@"%@ -> %s %s",c,ivar_getName(ivar),ivar_getTypeEncoding(ivar));
        }
        
        // 释放资源
        free(ivarList);
        
        // 获取父类
        c = class_getSuperclass(c);
    }
    
}

@end
