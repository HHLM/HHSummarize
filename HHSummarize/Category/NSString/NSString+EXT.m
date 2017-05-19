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

- (void)creatfile {
//    通过代码来创建plist文件，代码如下：
    
    //建立文件管理
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //找到Documents文件所在的路径
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //取得第一个Documents文件夹的路径
    
    NSString *filePath = [path objectAtIndex:0];
    
    //把TestPlist文件加入
    
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"test.plist"];
    
    //开始创建文件
    
    [fm createFileAtPath:plistPath contents:nil attributes:nil];
    
    //删除文件
    
    [fm removeItemAtPath:plistPath error:nil];
    
//    在写入数据之前，需要把要写入的数据先写入一个字典中，创建一个dictionary：
    
    //创建一个字典
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"zhangsan",@"1",@"lisi",@"2", nil];
    
    //把数据写入plist文件
    
    [dic writeToFile:plistPath atomically:YES];
    
//    读取plist中的数据，形式如下：
    
    //读取plist文件，首先需要把plist文件读取到字典中
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    //打印数据
    
    NSLog(@"key1 is %@",[dic2 valueForKey:@"1"]);
    
    NSLog(@"dic is %@",dic2);
    
//http://www.linuxidc.com
    
//    关于plist中的array读写，代码如下：
    
    //把TestPlist文件加入
    
    NSString *plistPaths = [filePath stringByAppendingPathComponent:@"tests.plist"];
    
    //开始创建文件
    
    [fm createFileAtPath:plistPaths contents:nil attributes:nil];
    
    //创建一个数组
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];
    
    //写入
    
    [arr writeToFile:plistPaths atomically:YES];
    
    //读取
    
    NSArray *arr1 = [NSArray arrayWithContentsOfFile:plistPaths];
    
    //打印
    
    NSLog(@"arr1is %@",arr1);
}
- (void)creat {
    //  在Documents目录下创建一个名为LaunchImage的文件夹
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"LaunchImage"];
    NSLog(@"%@",path);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir))
        
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建文件夹失败！");
        }
        NSLog(@"创建文件夹成功，文件路径%@",path);
    }
    
    UIImage *image=[UIImage imageWithContentsOfFile:@"testimage.png"];
    NSData *data = UIImagePNGRepresentation(image);
    //将testimage.png保存到LaunchImage文件夹下，新名称为image1.png
    BOOL isSaved=   [fileManager createFileAtPath:[path stringByAppendingString:@"/image1.png"] contents:data attributes:nil];
    NSLog(@"图片保存状态：%d",isSaved);
    
    //获取保存的图片
    UIImage *newimage=[UIImage imageWithContentsOfFile:[path stringByAppendingString:@"/image1.png"]];
    
    //   删除文件
    BOOL isDelete=[fileManager removeItemAtPath:path error:nil];
    NSLog(@"%d",isDelete);
}
@end
