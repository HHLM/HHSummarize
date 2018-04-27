//
//  HHBaseTableViewCell.m
//  HHSummarize
//
//  Created by Mac on 2018/4/27.
//  Copyright © 2018年 HHL. All rights reserved.
//

#import "HHBaseTableViewCell.h"

@implementation HHBaseTableViewCell


- (void)setColorSeparatorLine:(UIColor *)colorSeparatorLine
{
    _colorSeparatorLine = colorSeparatorLine;
    [self setNeedsLayout];
}
- (void)setOriginXSeparatorLine:(CGFloat)originXSeparatorLine
{
    _originXSeparatorLine = originXSeparatorLine;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (_originXSeparatorLine >= 0) {
        for (CALayer *layer in self.layer.sublayers) {
            if ([layer.name isEqualToString:@"separator"]) {
                [layer removeFromSuperlayer];
                break;
            }
        }
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        if (!self.heightSeparatorLine) {
            self.heightSeparatorLine = 0.5;
        }
        //划线
        CGPathRef path = CGPathCreateWithRect(CGRectMake(self.originXSeparatorLine, rect.size.height - self.heightSeparatorLine, rect.size.width, self.heightSeparatorLine), NULL);
        CGPathRelease(path);
        if (!self.colorSeparatorLine) {
            self.colorSeparatorLine = [UIColor redColor];
        }
        [shapeLayer setFillColor:self.colorSeparatorLine.CGColor];
        [shapeLayer setName:@"separator"];
        [self.layer addSublayer:shapeLayer];
    }else {
        for (CALayer *layer in self.layer.sublayers) {
            if ([layer.name isEqualToString:@"separator"]) {
                [layer removeFromSuperlayer];
                break;
            }
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
