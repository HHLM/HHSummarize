//
//  HHUILabelVC.m
//  HHSummarize
//
//  Created by LXH on 16/7/27.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHUILabelVC.h"
#import "HHFontStyleVC.h"
#import "HHCopyLabel.h"
#import "UILabel+autoSize.h"
#import "UIView+Frame.h"
@interface HHUILabelVC ()
@property (nonatomic, strong) UILabel  *htmlLab;
@end

@implementation HHUILabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    layerView.layer.shadowColor = [UIColor redColor].CGColor;
    // 设置阴影偏移量
    layerView.layer.shadowOffset = CGSizeMake(0,0);
    // 设置阴影透明度
    layerView.layer.shadowOpacity = 1;
    // 设置阴影半径
    layerView.layer.shadowRadius = 8;
    layerView.clipsToBounds = NO;
    layerView.layer.cornerRadius = 10;
    layerView.layer.masksToBounds = NO;
    layerView.layer.borderColor = [UIColor redColor].CGColor;
    //贝塞尔曲线添加
    //layerView.layer.shadowPath = bezierPath.CGPath;
    [self.view addSubview:layerView];

    
    
    // Do any additional setup after loading the view.
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 40)];
    lable.text = @"HHLM";
    lable.backgroundColor = [UIColor yellowColor];
    lable.textAlignment = NSTextAlignmentCenter;
//    lable.font = [UIFont systemFontOfSize:16];
    lable.textColor = [UIColor greenColor];
    
    //设置阴影 颜色阴影的偏移
    lable.shadowColor = [UIColor redColor];
    
//    lable.shadowOffset = CGSizeMake(10, 5);//右 下
    [self.view addSubview:lable];
    
//    [lable sizeToFit]; //让label自适应
    
    //文字大小自适应控件宽度
    lable.adjustsFontSizeToFitWidth = YES;
    /**
     文字折行方式
     */
    lable.lineBreakMode = NSLineBreakByCharWrapping;
    
    //系统字体
    NSArray *fonts = [UIFont familyNames];
    for (NSString *fontName in fonts) {
        DLog(@"字体名称---:%@",fontName);
    }
    lable.font = [UIFont fontWithName:@"Oriya Sangam MN" size:15];
    [self setMutableAttributedString];
    
    HHCopyLabel *label = [[HHCopyLabel alloc] initWithFrame:CGRectMake(10, 200, 100, 40)];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor redColor];
    label.text = @"长按可以复制我";
    [label autoSizeHorizontal];
    label.textColor =[UIColor greenColor];
    
    label.highLightColor = [UIColor yellowColor];
    
    UITextField *f = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 100, 40)];
    f.placeholder = @"HHLm";
    [self.view addSubview:f];
    
    HHCopyLabel *label1 = [[HHCopyLabel alloc] initWithFrame:CGRectMake(10, 300, 100, 40)];
    [self.view addSubview:label1];
    label1.backgroundColor = [UIColor redColor];
    label1.numberOfLines = 0;
    label1.text = @"长按可以跳转下一页长按可以跳转下一页长按可以跳转下一页长按可以跳转下一页";
    [label1 autoSizeVertical];
    label1.adjustsFontSizeToFitWidth = YES;
    label1.textColor =[UIColor greenColor];
    
    label1.highLightColor = [UIColor yellowColor];
    
    [self.view addSubview:self.htmlLab];
}
- (void)setMutableAttributedString
{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    lable.text = @"HHLMYNDM";
    lable.backgroundColor = [UIColor purpleColor];
    
    
    //给label加阴影
    lable.layer.shadowOpacity = 0.8;
//    lable.layer.shadowOffset = CGSizeMake(5, 5);
    lable.layer.shadowColor = [UIColor orangeColor].CGColor;
    
    [self.view addSubview:lable];
    
    /*--------------------第一种方式--------------*/
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"HHLMYNDM"];
    
    //设置指定字符串的颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(4, 2)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor] range:NSMakeRange(6, 2)];
    
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(1, 3)];
    
    lable.adjustsFontSizeToFitWidth = YES; //宽度固定 改变label的字体大小
    
    lable.attributedText = attributedString;
    
    /*--------------------第二种方式--------------*/
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    [str appendAttributedString:attributedString];
    
    NSDictionary *infoDic = @{NSForegroundColorAttributeName:[UIColor yellowColor],NSFontAttributeName:[UIFont systemFontOfSize:7]};
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"HHL" attributes:infoDic];
    [str appendAttributedString:str1];
    
    lable.attributedText = str;
//    [lable sizeThatFits:CGSizeMake(200, 20)];
    [lable sizeToFit];

}
- (CGFloat)widthWithSring:(NSString *)string font:(UIFont *)font
{
    CGSize size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    //各种属性
#if 0
    /*--------------------可以设置行间距 字间距--------------*/
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 3.0; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle.copy,NSKernAttributeName:@1.5f};
    /*--------------------上面--------------*/
#endif
    
    
    //文字的属性
    NSDictionary *attribtues = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle.copy};


    size = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribtues context:nil].size;
    return ceil(size.width) + 0.5;;
}
- (CGFloat)heighWithFontSring:(NSString *)string font:(UIFont *)font labelWidth:(CGFloat)width
{
    CGSize size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode  =  NSLineBreakByCharWrapping;
    NSDictionary *attribtues = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle.copy};
    size = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribtues context:nil].size;
    return ceil(size.height)+0.5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (point.y > 300) {
        HHFontStyleVC *vc =[[HHFontStyleVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//!< 为lable添加HTML格式的文本
- (void)addHTMLText
{
    
    NSString * htmlString = @"<html><body> 嘿嘿:<font size=\"20px\" color=\"green\">有钱就是这么任性!!!</font></body></html>";
    NSAttributedString *text ;
    text = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:nil];
    self.htmlLab.attributedText = text;
    
}
- (UILabel *)htmlLab{
    if (!_htmlLab) {
        _htmlLab = [[UILabel alloc] initWithFrame:CGRectMake(0,HHEIGHT - 200, self.view.width, 60)];
        _htmlLab.backgroundColor = [UIColor cyanColor];
        [self addHTMLText];
    }
    return _htmlLab;
}

@end
