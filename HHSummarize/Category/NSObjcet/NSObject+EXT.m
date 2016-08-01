//
//  NSObject+EXT.m
//  HHSummarize
//
//  Created by LXH on 16/7/31.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "NSObject+EXT.h"

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
@end
