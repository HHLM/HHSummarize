//
//  HHDreawView.m
//  HHChatView
//
//  Created by LXH on 2017/9/27.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHDreawView.h"

@implementation HHDreawView

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //遍历获取坐标 画圆点 连线
    for (int i = 0; i < _dataArray.count; i ++)
    {
        NSArray *array = _dataArray[i];
    
        CGPoint point = CGPointMake([[array firstObject] floatValue], 600-[[array lastObject] floatValue]);
        
        //画圆 圆心是坐标 半径是2
        CGContextAddArc(context, point.x, point.y, 2, 0, 2*M_PI, 0);
        //填充颜色
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillPath(context); //填充颜色
        CGContextDrawPath(context, kCGPathStroke);
        
        if (i == 0)
        {
            [path moveToPoint:CGPointMake(point.x,point.y)];
        }else
        {
            [path addLineToPoint:CGPointMake(point.x, point.y)];
        }
    }
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.bounds;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor redColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    [self.layer addSublayer:pathLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    
    
    
}


@end
