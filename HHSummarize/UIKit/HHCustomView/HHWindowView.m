//
//  HHWindowView.m
//  UISwitch
//
//  Created by HHL on 16/7/14.
//  Copyright © 2016年 LXH. All rights reserved.
//

#import "HHWindowView.h"
#import <UIKit/UIKit.h>


#define HHLoadWidth 60
#define kOffSet HHLoadWidth / 2

@implementation HHWindowView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    frame.size.width = HHLoadWidth;
    
    frame.size.height = HHLoadWidth;
    
    self = [super initWithFrame:frame];
    if (self)
    {
        //初始化背景视图
        
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _backgroundView.layer.cornerRadius = _backgroundView.frame.size.width / 2;
        
        _backgroundView.clipsToBounds = YES;
        
        _backgroundView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
        
        _backgroundView.userInteractionEnabled = NO;
        
        [self addSubview:_backgroundView];
        
        //初始化图片背景视图
        
        _imageBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame) - 10, CGRectGetHeight(self.frame) - 10)];
        
        _imageBackgroundView.layer.cornerRadius = _imageBackgroundView.frame.size.width / 2;
        
        _imageBackgroundView.clipsToBounds = YES;
        
        _imageBackgroundView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.8f];
        
        _imageBackgroundView.userInteractionEnabled = NO;
        
        [self addSubview:_imageBackgroundView];
        
        //初始化图片
        
        _imageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"icon_tempMarkup"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        _imageView.tintColor = [UIColor whiteColor];
        
        _imageView.frame = CGRectMake(0, 0, 30, 30);
        
        _imageView.center = CGPointMake(HHLoadWidth / 2 , HHLoadWidth / 2);
        
        [self addSubview:_imageView];
        
        //将正方形的view变成圆形
        
        self.layer.cornerRadius = HHLoadWidth / 2;
        
        
        //开启呼吸动画
        
        [self HighlightAnimation];
        [self show];
//         [self performSelector:@selector(show) withObject:nil afterDelay:0.000001];
    }
    return self;
}
+ (HHWindowView*)shareView
{
    UIView *window = [UIApplication sharedApplication].keyWindow;
    return [[self alloc] initWithFrame:CGRectMake(CGRectGetWidth(window.frame) - 80 , window.frame.size.height - 190, 60, 60)];
}
- (void)show
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window.rootViewController.view addSubview:self];
}
- (UIWindow *)getKeyWindow {
    id appDelegate = [UIApplication sharedApplication].delegate;
    UIWindow *keyWindow = [appDelegate valueForKey:@"window"];
    return keyWindow;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //得到触摸点
    UITouch *startTouch = [touches anyObject];
    self.startPoint = [startTouch locationInView:self.superview];
    //移除之前的
    [self.animator removeAllBehaviors];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //得到触摸点
//    NSSet *ss = [event allTouches];
    UITouch *startTouch = [touches anyObject];
    
    //将触摸点赋值给touchView的中心点 也就是根据触摸的位置实时修改view的位置
    self.center = [startTouch locationInView:self.superview];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //得到触摸点
    UITouch *endTouch = [touches anyObject];
    
    //返回触摸结束点
    
    self.endPoint = [endTouch locationInView:self.superview];
    
    //判断是否移动了视图(误差范围)
    CGFloat errorRange = 5;
    if (( self.endPoint.x - self.startPoint.x >= -errorRange &&
         self.endPoint.x - self.startPoint.x <= errorRange ) &&
        ( self.endPoint.y - self.startPoint.y >= -errorRange &&
         self.endPoint.y - self.startPoint.y <= errorRange ))
    {
        //没有移动
        if (self.downLoadBlock) {
            self.downLoadBlock();
            
            self.backgroundView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
            self.imageBackgroundView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];

        }
    }
    else
    {
        //移动了
        self.center = self.endPoint;
        //计算距离最近的边缘 吸附到边缘停靠
        CGFloat superWidth = self.superview.bounds.size.width;
        CGFloat superHeigh = self.superview.bounds.size.height;
        CGFloat endX = self.endPoint.x;
        CGFloat endY = self.endPoint.y;
        
        CGFloat topRange = endY; //上距离
        CGFloat bottomRange = superHeigh - endY;
        CGFloat leftRange = endX;
        CGFloat rightRange = superWidth - endX;
        
        //比较上下左右距离 取出最小值
        
        //上下的最小边距
        CGFloat minRangeV = topRange > bottomRange ? bottomRange : topRange;
        //左右的最小边距
        CGFloat minRangeH = leftRange > rightRange ? rightRange : leftRange;
        //最小边距
        CGFloat minRange = (minRangeV > minRangeH) ? minRangeH : minRangeV;
        
        
        //判断最小距离属于上下左右哪个方向 并设置该方向边缘的point属性
        CGPoint minPoint;
        if (minRange == topRange) {
            //上
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            endX = endX + kOffSet > superWidth ? superWidth -kOffSet:endX;
            minPoint = CGPointMake(endX, 0 + kOffSet);
        }
        else if (minRange == bottomRange)
        {
            //下
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            endX = endX + kOffSet > superWidth ? superWidth -kOffSet:endX;
            minPoint = CGPointMake(endX, superHeigh - kOffSet);
        }
        else if (minRange == leftRange)
        {
            //左
            endY = endY - kOffSet < 0?kOffSet:endY;
            
            endY = endY + kOffSet > superHeigh ? superHeigh - kOffSet:endY;
            minPoint = CGPointMake(0 + kOffSet, endY);
        }
        else {
            
            //右
            
            endY = endY - kOffSet < 0 ? kOffSet : endY;
            
            endY = endY + kOffSet > superHeigh ? superHeigh - kOffSet : endY;
            
            minPoint = CGPointMake(superWidth - kOffSet , endY);
        }
        //添加物理吸附效果
        UIAttachmentBehavior *actment = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:minPoint];
        [actment setLength:0];
        [actment setDamping:0.1];
        [actment setFrequency:5];
        [self.animator addBehavior:actment];

    }
}
#pragma mark ---LazyLoading
- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        // 创建物理仿真器(ReferenceView : 仿真范围)
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
        //设置代理
        _animator.delegate = self;
    }
    
    return _animator;
}
#pragma mark ---BreathingAnimation 呼吸动画
- (void)HighlightAnimation {
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:1.5f animations:^{
        
        Self.backgroundView.backgroundColor = [Self.backgroundView.backgroundColor colorWithAlphaComponent:0.1f];
        
    } completion:^(BOOL finished) {
        
        [Self DarkAnimation];
        
    }];
}
- (void)DarkAnimation{
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:1.5f animations:^{
        
        Self.backgroundView.backgroundColor = [Self.backgroundView.backgroundColor colorWithAlphaComponent:0.6f];
        
    } completion:^(BOOL finished) {
        
        [Self HighlightAnimation];
        
    }];
    
}
@end
