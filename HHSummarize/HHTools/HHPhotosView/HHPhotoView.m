//
//  HHPhotoView.m
//  HNNewspaper
//
//  Created by HHL on 16/1/21.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "HHPhotoView.h"



@implementation HHPhotoView
{
    NSMutableArray *photos;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        photos = [NSMutableArray array];
        [self creatUI:photos];
    }
    return self;
}
- (void)addImage:(NSArray *)images
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [photos setArray:images];
    [self creatUI:photos];
}
- (void)addImages
{
    if (_delegate && [_delegate respondsToSelector:@selector(photoAddImage)])
    {
        [_delegate photoAddImage];
    }
}
- (void)deleteImage:(UIButton *)btn
{
    [photos removeObjectAtIndex:btn.tag - 100];
    [self addImage:photos];
    if (_delegate &&[_delegate respondsToSelector:@selector(delateImages:index:)])
    {
        [_delegate delateImages:photos index:btn.tag - 100];
    }
}
- (void)creatUI:(NSArray *)array
{
    
    NSInteger N = 5;
    CGFloat leftX = 15;
    CGFloat SCREEN_WIDT = [UIScreen mainScreen].bounds.size.width;
    CGFloat WID = (SCREEN_WIDT - (N+1)*leftX)/N;
    CGFloat width = (SCREEN_WIDT - leftX)/N;
    
    for (int i = 0; i < array.count+1; i++)
    {
//        if (i == 4) {
//            return;
//        }
        CGFloat x = i%N *width;
        CGFloat y = i/N *width;
        if (i == array.count)
        {
            if (array.count == 10) {
                return;
            }
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x + leftX, y, WID+10, WID+10)];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(0, 10, WID, WID)];
            [btn setImage:[UIImage imageNamed:@"btn_upload"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(addImages) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:btn];
            [self addSubview:bgView];
            self.height = bgView.bottom + 15;
        }
        else
        {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x + leftX, y, WID+10, WID+10)];
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 10, WID, WID)];
            imgView.image = array[i];
            imgView.userInteractionEnabled = YES;
            [bgView addSubview:imgView];
            [self addSubview:bgView];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(WID - 10, 0, 20, 20)];
    
            [btn setImage:[UIImage imageNamed:@"pic_delete"] forState:UIControlStateNormal];
            btn.tag = 100+i;
            [btn addTarget:self
                    action:@selector(deleteImage:)
          forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:btn];
            self.height = bgView.bottom + 15;
            
        }
        
    }
}

@end
