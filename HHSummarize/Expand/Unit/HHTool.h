//
//  HHTool.h
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,HHFileBrowseMode){
    
    HHFolderBrowseModel = 0,
    HHCategoryBrowseModel  = 1
};

@interface HHTool : NSObject

/*--------------------文件------------------*/
//!<保存文件路径
+ (void)saverFileManagerAdress:(NSString *)adress;

//!<获取文件路径
+ (NSString *)fileManagerAdress;

//!<获取当前文件的浏览方式
+ (HHFileBrowseMode )fileBrowseModel;

//!<本地音乐路径
+ (NSString *)locationMusicPath;

//!<获取上传路径
+ (NSString *)upLoadingPath;

//!<获取下载路径
+ (NSString *)downloadPath;

//!< 添加上传图片到上传文件夹，并返回路径
+ (NSString *)addImageToUploading:(UIImage *)image imageName:(NSString *)name;

//!< 根据名字后缀获取图片
+ (UIImage *)fileImageWithSuffixName:(NSString *)suffix;

//!< 获取文件大小
+ (NSString *)stringWithFileSize:(NSUInteger)fileSize;


//!< 是否是图片
+ (BOOL)isImageFile:(NSString *)fileName;

//!< 是否是视频文件
+ (BOOL)isVideoFile:(NSString *)fileName;

//!< 是否是音乐文件
+ (BOOL)isMusicFile:(NSString *)fileName;

//!< 是否是文本文件
+ (BOOL)isDocumentFile:(NSString *)fileName;
/*--------------------文件------------------*/

/*--------------------加密------------------*/

//!< MD5加密
+ (NSString *)md5:(NSString *)key;
@end
