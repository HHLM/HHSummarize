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
        size.height = 8;
        size.width = 8;
        [subview setFrame:CGRectMake(subview.frame.origin.x,
                                     subview.frame.origin.x,
                                     size.width,
                                     size.height)];
        subview.layer.cornerRadius = size.width/2;;
        subview.clipsToBounds = YES;
        

        if (subviewIndex == page)
        {
            [subview setBackgroundColor:[UIColor redColor]];
        }
        else
        {
            [subview setBackgroundColor:[UIColor greenColor]];
        }
        
    }
}
@end

