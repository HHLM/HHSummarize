//
//  Color.h
//  HHSummarize
//
//  Created by LXH on 16/8/2.
//  Copyright © 2016年 HHL. All rights reserved.
//

#ifndef Color_h
#define Color_h

//调试用随机色
#if 0

#define DEBUG_COLOR [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0]

#elif 1

#define DEBUG_COLOR [UIColor clearColor]

#endif


//自定义的颜色(包括常用的红,黄,蓝,黑,灰,整个app的背景色)

//颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//带透明度的颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//16进制
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* Color_h */
