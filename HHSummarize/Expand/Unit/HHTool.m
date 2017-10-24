//
//  HHTool.m
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHTool.h"
#import <CommonCrypto/CommonDigest.h>

static NSString * const HHFileManagerAdress = @"HHFileManagerAdress";
static NSString * const HHFileBowseMode = @"HHFileBowseMode";
@implementation HHTool
#pragma mark -- 文件

/**
 typedef NS_OPTIONS(NSUInteger, NSStringCompareOptions) {
 NSCaseInsensitiveSearch = 1,       //不区分大小写比较
 
 NSLiteralSearch = 2,               //区分大小写比较
 
 NSBackwardsSearch = 4,             //从字符串末尾开始搜索
 
 NSAnchoredSearch = 8,              //搜索限制范围的字符串
 
 NSNumbericSearch = 64,             //按照字符串里的数字为依据，算出顺序。例如 Foo2.txt < Foo7.txt < Foo25.txt
 NSDiacriticInsensitiveSearch = 128,//忽略 "-" 符号的比较
 
 NSWidthInsensitiveSearch = 256,    //忽略字符串的长度，比较出结果
 
 NSForcedOrderingSearch = 512,      //忽略不区分大小写比较的选项，并强制返回 NSOrderedAscending 或者 NSOrderedDescending
 
 //以下定义高于 iphone 3.2 可用,
 NSRegularExpressionSearch = 1024,  //只能应用于 rangeOfString:..., stringByReplacingOccurrencesOfString:...和 replaceOccurrencesOfString:... 方法。使用通用兼容的比较方法，如果设置此项，可以去掉 NSCaseInsensitiveSearch 和 NSAnchoredSearch

};
 */
+ (NSString *)getDocumentsPath:(NSString *)fileName {
    //两种获取document路径的方式

    //NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    return path;
}
//NSDate转时间
+ (NSString *)dateStringFromDate:(NSDate *)date formate:(NSString *)formate;{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
//时间转成NSDate
+ (NSDate *)dateFormDateString:(NSString *)dateString formate:(NSString *)formate{
    NSDateFormatter *fotmatter = [[NSDateFormatter alloc] init];
    [fotmatter setDateFormat:formate];
    NSDate *date = [fotmatter dateFromString:dateString];
    return date;
}

+ (double)timeForDate:(NSDate *)date
{
    double time = [date timeIntervalSince1970];
    return time;
}
+ (NSString *)datefromTime:(long)tiem
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:tiem];
   return [HHTool dateStringFromDate:date formate:@"yyyyMMdd"];
}
//!< 时间转时间戳
+ (double)timeForDateString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:dateString];
    return [HHTool timeForDate:date];
}
//美国时间转成中国时间 //Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)formateString:(NSString *)dateString
{
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *date = [HHTool dateFormDateString:dateString formate:formate];
    NSString *dateStr = [HHTool dateStringFromDate:date formate:@"MM-dd:HH:mm"];
    return dateStr;
}

+ (NSString *)fileManagerAdress {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:HHFileManagerAdress];
}

+ (void)saverFileManagerAdress:(NSString *)adress {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:adress forKey:HHFileManagerAdress];
    [userDefaults synchronize];
}

+ (HHFileBrowseMode )fileBrowseModel
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:HHFileBowseMode];
}
+ (NSString *)locationMusicPath {
    
    NSString *musicPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Music"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:musicPath isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:musicPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"Create Music Directory Failed.");
        }
        DLog(@"%@",musicPath);
    }
    return musicPath;
}

+ (NSString *)upLoadingPath {
    NSString *uploadingPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"uploading"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:uploadingPath isDirectory:&isDir];
    if(!(isDirExist && isDir))    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:uploadingPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"Create uploading Directory Failed.");
        }
        DLog(@"%@",uploadingPath);
    }
    return uploadingPath;
}

+ (NSString *)downloadPath {
    NSString *downloadPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"download"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:downloadPath isDirectory:&isDir];
    if(!(isDirExist && isDir))    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"Create download Directory Failed.");
        }
        DLog(@"%@",downloadPath);
    }
    return downloadPath;
}
+ (NSString *)addImageToUploading:(UIImage *)image imageName:(NSString *)name {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    dateString = [[dateString componentsSeparatedByString:@":"] componentsJoinedByString:@""];
   NSString *imageName = [dateString stringByAppendingPathExtension:@"JPG"];
    
    NSString *uploadingPath = [HHTool upLoadingPath];
    uploadingPath = [uploadingPath stringByAppendingPathComponent:imageName];
    BOOL bResult = [UIImageJPEGRepresentation(image, .5f) writeToFile:uploadingPath atomically:YES];
    if (bResult)
    {
        return uploadingPath;
    }
    return nil;
}

+ (NSString *)stringWithFileSize:(NSUInteger)fileSize
{
    NSString *str = @"";
    
    if (fileSize < 1024)
    {
        str = [NSString stringWithFormat:@"%luByte", (unsigned long)fileSize];
    } else if (fileSize >= 1024 && fileSize < 1024*1024)
    {
        str = [NSString stringWithFormat:@"%.2fK", (float)(fileSize/1024.f)];
    } else
    {
        str = [NSString stringWithFormat:@"%.2fM", (float)(fileSize/(1024.f*1024.f))];
    }
    return str;
}
+ (UIImage *)fileImageWithSuffixName:(NSString *)suffix
{
    UIImage *image = nil;
    if ([suffix compare:@"rar" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [suffix compare:@"zip" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [suffix compare:@"arj" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [suffix compare:@"gz" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [suffix compare:@"z" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {//压缩文件
        image = [UIImage imageNamed:@"typeother.png"];
    } else if ([suffix compare:@"bmp" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"gif" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"pic" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"tif" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {//图形文件
        image = [UIImage imageNamed:@"typeimage.png"];
    } else if ([suffix compare:@"mov" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"avi" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"mpg" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"swf" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"mp4" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"tif" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {//视频文件
        image = [UIImage imageNamed:@"typemovie.png"];
    } else if ([suffix compare:@"mp3" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"wav" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"aif" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"au" options:NSCaseInsensitiveSearch] == NSOrderedSame  ||
               [suffix compare:@"ram" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"m4a" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {//声音文件
        image = [UIImage imageNamed:@"typemusic.png"];
    } else if ([suffix compare:@"pdf" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {//pdf
        image = [UIImage imageNamed:@"typefile.png"];
    } else if ([suffix compare:@"ppt" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {//ppt
        image = [UIImage imageNamed:@"typefile.png"];
    } else if ([suffix compare:@"doc" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"docx" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {//word
        image = [UIImage imageNamed:@"typefile.png"];
    } else if ([suffix compare:@"txt" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"rft" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"c" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"cpp" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"m" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"mm" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
               [suffix compare:@"sh" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {//文本文件
        image = [UIImage imageNamed:@"typefile.png"];
    } else
    {
        image = [UIImage imageNamed:@"typeother.png"];
    }
    return image;
}
+ (BOOL)isMusicFile:(NSString *)fileName {
    BOOL flag = NO;
    if ([fileName compare:@"mp3" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"wav" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"aif" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"au" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"ram" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        flag = YES;
    }
    return flag;
}
+ (BOOL)isImageFile:(NSString *)fileName {
    BOOL flag = NO;
    if ([fileName compare:@"bmp" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"gif" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"pic" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"png" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"tif" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        flag = YES;
    }
    return flag;
}
+ (BOOL)isVideoFile:(NSString *)fileName
{
    BOOL flag = NO;
    if ([fileName compare:@"mov" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"avi" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"mpg" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"swf" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"mp4" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"tif" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        flag = YES;
    }
    return flag;
}
+ (BOOL)isDocumentFile:(NSString *)fileName {
    BOOL flag = NO;
    if ([fileName compare:@"txt"  options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"rft"  options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"c"    options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"cpp"  options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"m"    options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"mm"   options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"sh"   options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"pdf"  options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"ppt"  options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"doc"  options:NSCaseInsensitiveSearch] == NSOrderedSame ||
        [fileName compare:@"docx" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        flag = YES;
    }
    return flag;
}
#pragma mark -- 文件加密
//!< MD5加密
+ (NSString *)md5:(NSString *)key
{
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *fileName = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return fileName;
}
//!< 判断是不是空数组
+ (BOOL)isEmptyString:(NSString *)string
{
    if (string.length == 0 || string == nil) {
        return NO;
    }else {
        //去除首尾空格
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (string > 0) {
            return YES;
        }
        return NO;
    }
    return NO;
}
@end
