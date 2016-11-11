//
//  HHTextView.h
//  HH
//
//  Created by LXH on 2016/11/8.
//  Copyright © 2016年 HHLM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
