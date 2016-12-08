//
//  HHUIGestureRecognizerVC.m
//  HHSummarize
//
//  Created by LXH on 2016/12/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHUIGestureRecognizerVC.h"

@interface HHUIGestureRecognizerVC ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *touchView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;//Pan手势识别器
@property (nonatomic, assign) CGPoint panStartPoint;//记录触摸起始点
@end

@implementation HHUIGestureRecognizerVC




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.touchView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognize:)];//初始化平移手势识别器(Pan)
    self.panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}
-(void)panGestureRecognize:(UIPanGestureRecognizer *)recognize{
    switch (recognize.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = [recognize translationInView:self.touchView];
            NSLog(@"**********开始 State: Began**********");
            NSLog(@"start point (%f, %f) in View", self.panStartPoint.x, self.panStartPoint.y);
            break;
            
        case UIGestureRecognizerStateChanged:
            NSLog(@"***********改变 State: Changed*********");
            CGPoint currentPoint = [recognize translationInView:self.touchView];
            
            /**
             判断运动范围
             */
            self.touchView.center = CGPointMake(self.touchView.center.x + currentPoint.x, self.touchView.center.y + currentPoint.y);
            if (self.touchView.center.x < self.touchView.frame.size.width/2) {
                self.touchView.center = CGPointMake(self.touchView.frame.size.width/2, self.touchView.center.y);
            }
            if (self.touchView.center.y < self.touchView.frame.size.height/2) {
                self.touchView.center = CGPointMake(self.touchView.center.x, self.touchView.frame.size.height/2);
            }
            if (self.touchView.center.x > self.view.frame.size.width - self.touchView.frame.size.width/2) {
                self.touchView.center = CGPointMake(self.view.frame.size.width - self.touchView.frame.size.width/2, self.touchView.center.y);
            }
            if (self.touchView.center.y > self.view.frame.size.height -self.touchView.frame.size.height/2) {
                self.touchView.center = CGPointMake(self.touchView.center.x, self.view.frame.size.height -self.touchView.frame.size.height/2);
            }
            [recognize setTranslation:CGPointMake(0, 0) inView:self.view];
            NSLog(@"current point (%f, %f) in View", currentPoint.x, currentPoint.y);
            break;
            
        case UIGestureRecognizerStateEnded:
            NSLog(@"************结束 State: Ended***********");
            CGPoint endPoint = [recognize translationInView:self.touchView];
            NSLog(@"end point (%f, %f) in View", endPoint.x, endPoint.y);
            
            
            if (self.touchView.center.x <= self.view.frame.size.width/2) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.touchView.center = CGPointMake(self.touchView.frame.size.width/2, self.touchView.center.y);
                }];
                
            }else{
                [UIView animateWithDuration:0.25 animations:^{
                    self.touchView.center = CGPointMake(self.view.frame.size.width - self.touchView.frame.size.width/2, self.touchView.center.y);
                }];
                
            }
            break;
            
        case UIGestureRecognizerStateCancelled:
            NSLog(@"************取消 State: Cancelled*********");
            break;
            
        case UIGestureRecognizerStateFailed:
            NSLog(@"************失败 State: Failed************");
            break;
        default:
            break;
    }
}

#pragma mark -- UI
- (UIView *)touchView{
    if (!_touchView) {
        _touchView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
        _touchView.backgroundColor = [UIColor redColor];
        _touchView.layer.cornerRadius = 30;
        _touchView.clipsToBounds = YES;
    }
    return _touchView;
}


@end
