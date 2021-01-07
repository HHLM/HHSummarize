//
//  HHPageController.m
//  CycleImageView
//
//  Created by LXH on 15/9/28.
//  Copyright (c) 2015年 LXH. All rights reserved.
//

#import "HHPageController.h"

@implementation HHPageController

//重写方法 改变点点的大小
- (void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++)
    {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 5;
        size.width = 15;
        [subview setFrame:CGRectMake(subview.frame.origin.x,
                                     subview.frame.origin.x,
                                     size.width,
                                     size.height)];
        subview.layer.cornerRadius = size.height/2;;
        subview.clipsToBounds = YES;
        

        if (subviewIndex == page)
        {
            [subview setBackgroundColor:[UIColor redColor]];
            subview.width = 15;
        }
        else
        {
            [subview setBackgroundColor:[UIColor greenColor]];
            subview.width = 5;
            if (subviewIndex > page) {
                subview.x = subview.x + 10;
            }
        }
        
    }
}
@end

