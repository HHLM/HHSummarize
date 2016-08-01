//
//  UIView+EXT.m
//  HHSummarize
//
//  Created by LXH on 16/8/1.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "UIView+EXT.h"

@implementation UIView (EXT)
- (UIView*)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse
{
    for( UIView* subview in self.subviews ) {
        
        BOOL stop = NO;
        if( recurse( subview, &stop ) )
        {
            return [subview findViewRecursively:recurse];
        }
        else if( stop )
        {
            return subview;
        }
    }
    
    return nil;
}
@end
