//
//  HHCellView.m
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//
#import "HHCellView.h"

@implementation HHCellView
@synthesize photoView,titleLabel,numberLabel,deletaBtn;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        CGFloat width = CGRectGetWidth(self.frame);
        
        self.backgroundColor =[UIColor whiteColor];
        photoView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, width-10, width+40)];
        [self addSubview:photoView];
        photoView.backgroundColor = [UIColor clearColor];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(photoView.frame), width, 15)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.text = @"我要冲照片";
        [self addSubview:titleLabel];
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+2, width, 14)];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = [UIFont systemFontOfSize:12];
        numberLabel.text = @"共6张";
        [self addSubview:numberLabel];
        
        _heigh = CGRectGetMaxY(numberLabel.frame)+5;
        
    }
    return self;
}
- (void)model:(HHModel*)model
{
  
    self.titleLabel.text = model.title;
    self.numberLabel.text = model.number;
    self.photoView.image = [UIImage imageNamed:model.image];
    
#if 1
    self.photoView.image = [HHUnit imageWithScale:self.photoView.width/self.photoView.height image:self.photoView.image];
    
#else
    
    UIImage *image = [UIImage imageNamed:model.image];
    
    CGRect rect = CGRectMake(60, 0,  image.size.height*(1- 40/(40+self.photoView.frame.size.width)), image.size.height);
    
    /** < 在原来图片的尺寸的基础上 按照新的尺寸截图 > **/
    image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
    self.photoView.image = image;
#endif
    

}
@end
