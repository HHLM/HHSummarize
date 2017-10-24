//
//  UIImage+EXT.m
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "UIImage+EXT.h"

@implementation UIImage (EXT)
//!< 生成二维码
+ (UIImage *)mdQRCodeForString:(NSString *)qrString
                          size:(CGFloat)size {
    return nil;
}

//!< 生成带颜色的二维码
+ (UIImage *)mdQRCodeForString:(NSString *)qrString
                          size:(CGFloat)size
                     fillColor:(UIColor *)fillColor {
    return nil;
}

#pragma mark - 对图片进行滤镜处理
/** 对图片进行滤镜处理 */
// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:name];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

/** 对图片进行模糊处理 */
// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter;
    if (name.length != 0) {
        filter = [CIFilter filterWithName:name];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![name isEqualToString:@"CIMedianFilter"]) {
            [filter setValue:@(radius) forKey:@"inputRadius"];
        }
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    }else{
        return nil;
    }
}


/**
 *  调整图片饱和度, 亮度, 对比度
 *
 *  @param image      目标图片
 *  @param saturation 饱和度
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度
 *
 */
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];// 0.0 ~ 1.0
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

/** 截取view生成一张图片 */
+ (UIImage *)shotWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 全屏截图 */
+ (UIImage *)shotScreen{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(window.bounds.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 截取view中某个区域生成一张图片 */
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self shotWithView:view].CGImage, scope);
    UIGraphicsBeginImageContext(scope.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
    CGContextTranslateCTM(context, 0, rect.size.height);//下移
    CGContextScaleCTM(context, 1.0f, -1.0f);//上翻
    CGContextDrawImage(context, rect, imageRef);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return image;
}
/** 压缩图片到指定尺寸大小 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage *resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return resultImage;
}
/**
 *  画圆图片裁剪
 *
 *  @return 裁剪完成的图片
 */
- (instancetype)circleImage{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 添加路径到上下文
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪（根据添加到上下文中的路径进行裁剪）
    // 以后超出裁剪后形状的内容都看不见
    CGContextClip(context);
    
    // 绘制图片到上下文中
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name{
    return [[self imageNamed:name] circleImage];
}


@end
