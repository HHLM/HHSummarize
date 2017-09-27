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


/*--------------------------- 手势的介绍 ---------------------------*/

#pragma mark -- 属性
/**
 
 //设置代理
 @property(nullable,nonatomic,weak) id <UIGestureRecognizerDelegate> delegate;
 
 //设置手势是否有效
 @property(nonatomic, getter=isEnabled) BOOL enabled;
 
 //获取手势所在的view
 @property(nullable, nonatomic,readonly) UIView *view;
 
 //获取触发触摸的点
 - (CGPoint)locationInView:(nullable UIView*)view;
 
 //设置触摸点数
 - (NSUInteger)numberOfTouches;
 
 //获取某一个触摸点的触摸位置
 - (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(nullable UIView*)view;
 
 //属性默认为YES
 @property(nonatomic) BOOL cancelsTouchesInView;

    当这个属性设置为YES时，如果识别到了手势，系统将会发送touchesCancelled:withEvent:消息在其时间传递链上，
 终止触摸事件的传递，设置为NO，则不会终止事件的传
 
 @property(nonatomic) BOOL delaysTouchesBegan;
     在一个手势触发之前，是会一并发消息给事件传递链的，delaysTouchesBgan属性用于控制这个消息的传递时机，默认这个属
 性为NO，此时在触摸开始的时候，就会发消息给事件传递链，如果我们设置为YES，在触摸没有被识别失败前，都不会给事件传递链发送消息。
 
 @property(nonatomic) BOOL delaysTouchesEnded;
 这个属性设置手势识别结束后，是立刻发送touchesEnded消息到事件传递链或者等待一个很短的时间后，如果没有接收到新的手势识别任务，再发送。
 
 */
/*--------------------------- Delegate ---------------------------*/
#pragma mark -- 代理方法
/**
 
 //手指触摸屏幕后回调的方法，返回NO则不再进行手势识别，方法触发等
 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
 
 //开始进行手势识别时调用的方法，返回NO则结束，不再触发手势
 - (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
 
 //是否支持多时候触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
 
 //下面这个两个方法也是用来控制手势的互斥执行的
 
 //这个方法返回YES，第一个手势和第二个互斥时，第一个会失效
 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
 
 //这个方法返回YES，第一个和第二个互斥时，第二个会失效
 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
 
 */


/**
 
 
 点击手势——UITapGestureRecognizer
 
 点击手势十分简单，支持单击和多次点击，在我们手指触摸屏幕并抬起手指时会进行触发，其中有如下两个属性我们可以进行设置：
 
 //设置点击次数，默认为单击
 @property (nonatomic) NSUInteger  numberOfTapsRequired;
 //设置同时点击的手指数
 @property (nonatomic) NSUInteger  numberOfTouchesRequired;
 
 
 
 
 捏合手势——UIPinchGestureRecognizer
 
 捏合手势是当我们双指捏合和扩张会触发动作的手势，我们可以设置的属性如下：
 
 //设置缩放比例
 @property (nonatomic)          CGFloat scale;
 //设置捏合速度
 @property (nonatomic,readonly) CGFloat velocity;
 
 
 
 拖拽手势——UIPanGestureRecognzer
 
 当我们点中视图进行慢速拖拽时会触发拖拽手势的方法。
 
 //设置触发拖拽的最少触摸点，默认为1
 @property (nonatomic)          NSUInteger minimumNumberOfTouches;
 //设置触发拖拽的最多触摸点
 @property (nonatomic)          NSUInteger maximumNumberOfTouches;
 //获取当前位置
 - (CGPoint)translationInView:(nullable UIView *)view;
 //设置当前位置
 - (void)setTranslation:(CGPoint)translation inView:(nullable UIView *)view;
 //设置拖拽速度
 - (CGPoint)velocityInView:(nullable UIView *)view;
 
 
 
 
 滑动手势——UISwipeGestureRecognizer
 
 滑动手势和拖拽手势的不同之处在于滑动手势更快，拖拽比较慢。
 
 //设置触发滑动手势的触摸点数
 @property(nonatomic) NSUInteger                        numberOfTouchesRequired;
 //设置滑动方向
 @property(nonatomic) UISwipeGestureRecognizerDirection direction;
 //枚举如下
 typedef NS_OPTIONS(NSUInteger, UISwipeGestureRecognizerDirection) {
 UISwipeGestureRecognizerDirectionRight = 1 << 0,
 UISwipeGestureRecognizerDirectionLeft  = 1 << 1,
 UISwipeGestureRecognizerDirectionUp    = 1 << 2,
 UISwipeGestureRecognizerDirectionDown  = 1 << 3
 };
 
 
 
 旋转手势——UIRotationGestureRecognizer
 
 进行旋转动作时触发手势方法。
 
 //设置旋转角度
 @property (nonatomic)          CGFloat rotation;
 //设置旋转速度
 @property (nonatomic,readonly) CGFloat velocity;
 
 
 
 长按手势——UILongPressGestureRecognizer
 
 进行长按的时候触发的手势方法。
 
 //设置触发前的点击次数
 @property (nonatomic) NSUInteger numberOfTapsRequired;
 //设置触发的触摸点数
 @property (nonatomic) NSUInteger numberOfTouchesRequired;
 //设置最短的长按时间
 @property (nonatomic) CFTimeInterval minimumPressDuration;
 //设置在按触时时允许移动的最大距离 默认为10像素
 @property (nonatomic) CGFloat allowableMovement;
 
 
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.touchView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognize:)];//初始化平移手势识别器(Pan)
    self.panGestureRecognizer.delegate = self;
    [self.touchView addGestureRecognizer:self.panGestureRecognizer];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];;
    
    //view.backgroundColor = [UIColor redColor];
    
    //ges.delegate=self;
    [self.touchView addGestureRecognizer:ges];
    
    UIPanGestureRecognizer * ges2 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(requireGestureRecognizerToFail:)];
    //    ges2.delegate=self;
//    [self.touchView addGestureRecognizer:ges2];

}

- (void)requireGestureRecognizerToFail:(UIPanGestureRecognizer *)panGR
{
    CGPoint point = [panGR translationInView:self.view];
    
    //左移
    if (point.x < 0)
    {
        //如果没有出边界就可以移动
        if (panGR.view.frame.origin.x >= 0)
        {
            //panGR.view 为添加手势的那个view
            panGR.view.frame = CGRectMake(panGR.view.frame.origin.x + point.x, panGR.view.frame.origin.y + point.y, 100, 100);
        }
    }
    else
    {
        //如果右移 没有出右侧边界
        if (panGR.view.frame.origin.x + panGR.view.frame.size.width <= CGRectGetWidth(self.view.frame))
        {
            panGR.view.frame = CGRectMake(panGR.view.frame.origin.x + point.x, panGR.view.frame.origin.y + point.y, 100, 100);
        }
    }
    //清零
    [panGR setTranslation:CGPointZero inView:self.view];

}

-(void)click:(UIGestureRecognizer *)ges{
    
    NSLog(@"第一个手势的触发方法");
    
}
-(void)click1:(UIGestureRecognizer *)ges1{
    NSLog(@"第二个手势的触发方法");
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
