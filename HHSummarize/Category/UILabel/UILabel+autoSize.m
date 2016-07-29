//
//  UILabel+autoSize.m
//  HHSummarize
//
//  Created by LXH on 16/7/29.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "UILabel+autoSize.h"

@implementation UILabel (autoSize)
- (UILabel *)autoSizeVertical {
    return [self autoSizeVertical:0];
}
- (UILabel *)autoSizeHorizontal {
    return [self autoSizeHorizontal:0];
}
- (UILabel *)autoSizeHorizontal:(CGFloat)minWidth {
    
    CGRect newFrame = self.frame;
    
    CGSize autoSize = CGSizeMake(CGFLOAT_MAX, self.frame.size.height);
    
    NSString *string = self.text;
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.lineBreakMode = NSLineBreakByCharWrapping;
        
        NSDictionary *dic = @{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:style.copy};
        
      CGSize size = [string boundingRectWithSize:autoSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:dic context:nil].size;
        
        newFrame.size.width = ceil(size.width)+0.5;
    }
    if (minWidth > 0) {
        newFrame.size.width = (minWidth > newFrame.size.width)?minWidth:newFrame.size.width;
    }
    self.frame = newFrame;
    return self;
}
- (UILabel *)autoSizeVertical:(CGFloat)minHeigh {
    CGRect newFrame = self.frame;
    
    CGSize autoSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    
    NSString *string = self.text;
    
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.lineBreakMode = NSLineBreakByCharWrapping;
        
        NSDictionary *dic = @{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:style.copy};
        
        CGSize size = [string boundingRectWithSize:autoSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:dic context:nil].size;
        
        newFrame.size.height = ceil(size.height)+0.5;
    }
    if (minHeigh > 0) {
        newFrame.size.height = (minHeigh > newFrame.size.height)?minHeigh:newFrame.size.height;
    }
    self.frame = newFrame;
    return self;
}
@end
