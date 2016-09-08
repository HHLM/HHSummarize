//
//  HHUnit.m
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHUnit.h"

@implementation HHUnit
+ (UIImage *)imageWithScale:(CGFloat)scale image:(UIImage *)image
{
    // scale 是imageView的宽度和高度的比例 image是imageView的图片
    
    CGFloat w  = image.size.width;
    
    CGFloat h = image.size.height;
    
    CGRect rect;
    
    if (w / h > scale) {
        //说明图片的宽度多余  截取图片的宽度是
        
        CGFloat width = image.size.height *scale;
        
        rect =  CGRectMake((w - width)/2, 0,width, h); //这样写是截取图片中间区域
    }
    else
    {
        //说明图片的高度多余 截取图片的高度是
        CGFloat heigh = image.size.width/scale;
        
        rect =  CGRectMake(0, (h - heigh)/2,w, heigh);
    }
    /** < 在原来图片的尺寸的基础上 按照新的尺寸截图 > **/
    image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
    
    return image;
}
#pragma mark 等比压缩图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
#pragma mark -- 圆形图片
+(UIImage *)roundImage:(UIImage *) image toSize:(CGSize)size radius: (float) radius
{
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:radius] addClip];
    [image drawInRect:rect];
    UIImage* rounded = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rounded;
}
#pragma mark 生成纯色图片的函数
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark -- image的翻转
+ (UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            break;
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

#pragma mark -- 时间处理
//NSDate转时间
+ (NSString *)dateStringFromDate:(NSDate *)date formate:(NSString *)formate {
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
    return [HHUnit dateStringFromDate:date formate:@"yyyyMMdd"];
}
//!< 时间转时间戳
+ (double)timeForDateString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:dateString];
    return [HHUnit timeForDate:date];
}
//美国时间转成中国时间 //Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)formateString:(NSString *)dateString
{
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *date = [HHUnit dateFormDateString:dateString formate:formate];
    NSString *dateStr = [HHUnit dateStringFromDate:date formate:@"MM-dd:HH:mm"];
    return dateStr;
}
//随机颜色
+ (UIColor *)randomColor
{
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        srand48(time(0));
    }
    CGFloat r = (CGFloat)drand48();
    CGFloat g = (CGFloat)drand48();
    CGFloat b = (CGFloat)drand48();
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}
@end
