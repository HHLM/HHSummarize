//
//  UIView+EXT.h
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EXT)
- (UIView*)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;
@end
