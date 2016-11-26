//
//  NSString+EXT.m
//  HHSummarize
//
//  Created by LXH on 16/7/31.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "NSString+EXT.h"

@implementation NSString (EXT)

- (NSString *)cleanString:(NSString *)str {
    if (str == nil) {
        return @"";
    }
    NSMutableString *cleanString = [NSMutableString stringWithString:str];
    [cleanString replaceOccurrencesOfString:@"\n" withString:@""
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [cleanString length])];
    [cleanString replaceOccurrencesOfString:@"\r" withString:@""
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [cleanString length])];
    return cleanString;
}

- (BOOL)isEmptyString {
    if (self.length == 0 ||self == nil) {
        return NO;
    }
    else{
        //去掉首位的空格
        if ([self stringByTrimmingSpace].length > 0) {
            return YES;
        }
        else{
            return NO;
        }
    }
    return NO;
}
- (NSString *)stringByRemovingSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
- (NSString *)stringByTrimmingSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSArray *)cleanSpaceArray:(NSArray *)array
{
    array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
    return array;
}

+(NSURL *)HTTPURLFromString:(NSString *)string
{
    NSString *searchString = @"http";
    NSRange prefixRange = [string rangeOfString:searchString options:(NSCaseInsensitiveSearch | NSAnchoredSearch)];
    
    if (prefixRange.length == 4) {
        return [NSURL URLWithString:string];
    }
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", string]];
    
}
@end
