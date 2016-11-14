//
//  HHToolBar.h
//  推送
//
//  Created by LXH on 2016/11/7.
//  Copyright © 2016年 HHLM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HHToolType) {
    HHToolDone = 0,
    HHToolCancel = 1
};

@interface HHToolBar : UIToolbar

/**
 创建tool 左边按钮邮编按钮

 @param target self
 @param canCelAction 左边按钮事件
 @param doneAction 右边按钮事件
 @return tool
*/

- (id)initWithTarget:(id)target
        canCelAction:(SEL)canCelAction
          doneAction:(SEL)doneAction;

@end
