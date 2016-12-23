//
//  HHColumnView.m
//  HHSummarize
//
//  Created by LXH on 2016/12/14.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHColumnView.h"

#define HHItmePadding   8.0f
#define HHSWidth        self.frame.size.width


@interface HHColumnView ()
{
    NSArray *titleArray;
    NSMutableArray  *buttonArray;
    CGFloat         ZXItemMargin;
    CGFloat         ZXItemFontSize;
}
@property (nonatomic, assign) HHColumnType  columnType;     //类型风格
@property (nonatomic, strong) UIView        *lineView;
@property (nonatomic, strong) UIButton      *selectbutton;  //被选中的按钮
@property (nonatomic, assign) CGFloat       cornerRadius;   //圆弧大小 默认是6
@property (nonatomic, assign) CGFloat       lineWidth;      //线条宽度
@property (nonatomic, assign) CGFloat       lineY;          //线条的Y坐标
@property (nonatomic, assign) CGFloat       buttonHeigh;    //按钮高度
@property (nonatomic, assign) CGFloat       lineHeigh;      //线条高度
@property (nonatomic, assign) BOOL          isClipButton;   //是否剪切
@property (nonatomic, assign) CGFloat       maxWidth;       //按钮的X坐标

@property (nonatomic, strong) UIColor       *normalColor;   //普通颜色
@property (nonatomic, strong) UIColor       *selcetColor;   //选中颜色
@property (nonatomic, strong) UIColor       *lineColor;     //滑块颜色


@end


@implementation HHColumnView
- (instancetype)initWithFrame:(CGRect)frame
                    styleType:(HHColumnType)styleType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.columnType = styleType;
        [self config];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if ([super initWithCoder:coder]) {
        [self config];
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]){
        [self config];
    }
    return self;
}
//设置默认属性
- (void)config
{
    ZXItemMargin = 20.0f;
    ZXItemFontSize = 18.0f;
    self.normalColor   = [UIColor lightGrayColor];
    self.selcetColor   = [UIColor redColor];
    self.lineColor = [UIColor redColor];
    buttonArray = [NSMutableArray array];
    self.showsHorizontalScrollIndicator = NO;
    //    [self creatColumn];
}
- (void)setItemDefaultColor:(UIColor *)itemDefaultColor {
    self.normalColor = itemDefaultColor;
    [self creatColumn];
    
}
- (void)setItemSelectColor:(UIColor *)itemSelectColor {
    self.selcetColor = itemSelectColor;
    [self creatColumn];
    
}
- (void)setItemMargin:(CGFloat)itemMargin {
    if (itemMargin) {
        ZXItemMargin = itemMargin;
        [self creatColumn];
    }
    
}
- (void)setRoundColor:(UIColor *)roundColor {
    self.lineColor = roundColor;
}
- (void)setItemFontSize:(CGFloat)itemFontSize {
    if (itemFontSize) {
        ZXItemFontSize = itemFontSize;
        [self creatColumn];
    }
}
- (void)setColumnArray:(NSArray *)columnArray {
    titleArray = [columnArray copy];
    [self creatColumn];
}
- (void)itemClick:(UIButton *)button
{
    if (self.selectbutton == button) {
        return;
    }
    
    if (_columnDelegate && [_columnDelegate respondsToSelector:@selector(columunViewSelectItem:)])
    {
        [_columnDelegate columunViewSelectItem:button.tag - 100];
    }
    self.selectbutton.selected = NO;
    button.selected = YES;
    self.selectbutton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.x = button.x;
        self.lineView.width = button.width;
        
        CGFloat scrollerWidth = self.contentSize.width;
        
        if (scrollerWidth > self.frame.size.width) //当内容大于屏幕宽度时候
        {
            CGFloat offsetx = button.center.x - self.frame.size.width * 0.5;
            
            CGFloat offsetMax = self.contentSize.width - self.frame.size.width;
            
            if (offsetx < 0)
            {
                offsetx = 0;
            }
            else if (offsetx > offsetMax)
            {
                offsetx = offsetMax;
            }
            
            CGPoint offset = CGPointMake(offsetx, self.contentOffset.y);
            
            [self setContentOffset:offset animated:YES];
        }

    } completion:^(BOOL finished) {
        
//        CGFloat scrollerWidth = self.contentSize.width;
//        
//        if (scrollerWidth > self.frame.size.width) //当内容大于屏幕宽度时候
//        {
//            CGFloat offsetx = button.center.x - self.frame.size.width * 0.5;
//            
//            CGFloat offsetMax = self.contentSize.width - self.frame.size.width;
//            
//            if (offsetx < 0)
//            {
//                offsetx = 0;
//            }
//            else if (offsetx > offsetMax)
//            {
//                offsetx = offsetMax;
//            }
//            
//            CGPoint offset = CGPointMake(offsetx, self.contentOffset.y);
//            
//            [self setContentOffset:offset animated:YES];
//        }
    }];
}
- (void)creatColumn
{
    [self setColumnStyle];
    if (titleArray.count) {
        [self creatItem];
        if (self.contentSize.width < self.width) {
            [self autoItemSize];
        }
    }
    
    
}
- (void)selectItemAtIndex:(NSInteger)index {
    UIButton *button = (UIButton *)[self viewWithTag:index+100];
    [self itemClick:button];
}
- (void)autoItemSize
{
    CGFloat bigButtonSumWidth = 0;
    int bigButtonCount = 0;
    self.maxWidth = ZXItemMargin;
    CGFloat width =
    (HHSWidth - (buttonArray.count + 1) * ZXItemMargin) /
    buttonArray.count;
    for (int i = 0; i < buttonArray.count; i++)
    {
        UIButton *button = buttonArray[i];
        if (button.frame.size.width > width)
        {
            bigButtonCount++;
            bigButtonSumWidth += button.frame.size.width;
        }
    }
    width = (HHSWidth - (buttonArray.count + 1) * ZXItemMargin - bigButtonSumWidth) / (buttonArray.count - bigButtonCount);
    for (int i = 0; i < buttonArray.count; i++)
    {
        UIButton *button = buttonArray[i];
        if (button.frame.size.width < width)
        {
            button.frame =
            CGRectMake(self.maxWidth, 0, width, self.frame.size.height);
            self.maxWidth += width + ZXItemMargin;
        }
        else
        {
            button.frame = CGRectMake(self.maxWidth, 0, button.frame.size.width, self.frame.size.height);
            self.maxWidth += button.frame.size.width + ZXItemMargin;
        }
        if (button == self.selectbutton)
        {
            self.lineView.frame = CGRectMake(button.frame.origin.x, self.lineY, button.frame.size.width, self.lineHeigh);
        }
    }
    self.contentSize = CGSizeMake(self.maxWidth, -4);
    
}
- (void)creatItem{
    for (int i = 0; i < titleArray.count; i ++) {
        
        CGFloat itemWidth = [self itemWidth:titleArray[i]];
        UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonItem setFrame:CGRectMake(self.maxWidth, 0, itemWidth, self.height)];
        buttonItem.titleLabel.font = [UIFont systemFontOfSize:ZXItemFontSize];
        [buttonItem setTitle:titleArray[i] forState:UIControlStateNormal];
        buttonItem.tag = 100+i;
        [buttonItem setTitleColor:self.normalColor
                         forState:UIControlStateNormal];
        [buttonItem setTitleColor:self.selcetColor
                         forState:UIControlStateSelected];
        
        [buttonItem addTarget:self
                       action:@selector(itemClick:)
             forControlEvents:UIControlEventTouchUpInside];
        
        self.maxWidth += itemWidth + ZXItemMargin;
        [buttonArray addObject:buttonItem];
        
        
        if (0 == i)
        {
            self.selectbutton = buttonItem;
            buttonItem.selected = YES;
            self.lineView.x = buttonItem.x;
            self.lineView.width = buttonItem.width;
            [self itemClick:buttonItem];
            [self addSubview:self.lineView];
        }
        [self addSubview:buttonItem];
        self.contentSize = CGSizeMake(CGRectGetMaxX(buttonItem.frame) + ZXItemMargin, 0);
    }
}
/**
 设置风格默认高度
 */
- (void)setColumnStyle
{
    /** 移除所有的的子view */
    if (self.subviews) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    self.maxWidth = ZXItemMargin;
    switch (self.columnType) {
        case HHColumnLineType:
        {
            self.lineY      = self.frame.size.height - 2;
            self.lineHeigh  = 2.0f;
        }
            break;
        case HHColumnRoundType:
        {
            self.lineY = HHItmePadding;
            self.lineHeigh  = self.frame.size.height - HHItmePadding * 2;
            self.cornerRadius = 6.0f;
            self.isClipButton = YES;
            self.selcetColor = self.normalColor;
            self.lineView.layer.cornerRadius = self.cornerRadius;
            self.lineView.clipsToBounds = self.isClipButton;
        }
            break;
        case HHColumnTextType:
        {
            self.lineY = 0;
            self.lineHeigh = 0.0f;
            self.isClipButton = NO;
        }
            break;
            
        default:
            break;
    }
    self.lineView.backgroundColor = self.lineColor;
}

- (CGFloat)itemWidth:(NSString *)item
{
    CGFloat itemWidth = [self textWidthWithFontSize:ZXItemFontSize
                                               Text:item];
    switch (self.columnType) {
        case HHColumnLineType:
            break;
        case HHColumnRoundType:
            itemWidth = itemWidth + HHItmePadding * 2;
            break;
        case HHColumnTextType:
            break;
    }
    return itemWidth;
}


//计算本文宽度
- (CGFloat)textWidthWithFontSize:(CGFloat)fontSize
                            Text:(NSString *)text
{
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGRect size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attr
                                     context:nil];
    return size.size.width;
}

#pragma mark -- 线条
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0,self.lineY, self.lineWidth, self.lineHeigh)];
    }
    return _lineView;
}
@end
