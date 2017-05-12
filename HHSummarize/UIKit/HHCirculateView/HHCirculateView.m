//
//  HHCirculateView.m
//  HHSummarize
//
//  Created by LXH on 2017/5/11.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "HHCirculateView.h"
#import "HHPageController.h"

#define KWIDTH                  CGRectGetWidth(self.frame)
#define KHEIGHT                 CGRectGetHeight(self.frame)

@interface HHCirculateView ()<UIScrollViewDelegate>

@property (nonatomic, strong) HHPageController *h_pageControl;

@property (nonatomic, strong) UIScrollView  *mySrollerView;

@property (nonatomic, strong) UIPageControl *pageControl;
//展示栏目
@property (nonatomic, strong) UIView        *showView;
//文字介绍
@property (nonatomic, strong) UILabel       *textLable;

@property (nonatomic, weak)   NSTimer       *timer;         //定时器

@property (nonatomic, strong) NSMutableArray *images;       //所有图片

@property (nonatomic, strong) NSMutableArray *titles;       //文字

// 当前选中的第几个图片
@property (nonatomic, assign) NSInteger      selectIndex;

@property (nonatomic, assign) BOOL           isURLImg;//是否加载网络的图片

@end

@implementation HHCirculateView

- (void)setImageArray:(NSArray *)imageArray {
    [self.images setArray:imageArray];
    if (self.images.count > 0) {
        _isURLImg = NO;
        [self refershUI];
    }
}
- (void)setImageURLArray:(NSArray *)imageURLArray {
    [self.images setArray:imageURLArray];
    if (self.images.count > 0) {
        _isURLImg = YES;
        [self refershUI];
    }
    
}
- (void)setTitleArray:(NSArray *)titleArray {
    [self.titles setArray:titleArray];
}
- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;
}
- (void)setTextFout:(UIFont *)textFout {
    _textFout = textFout;
    self.textLable.font = _textFout;
}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textLable.textColor = _textColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    self.pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setAutoSroller:(BOOL)autoSroller {
    _autoSroller = autoSroller;
    if (_autoSroller) {
        [self setupTimer]; //添加定时器
    }
}
- (void)setAutoSrollerTimerInterval:(CGFloat)autoSrollerTimerInterval {
    _autoSrollerTimerInterval = autoSrollerTimerInterval;
}
- (void)setBlock:(HHCirculateblock)block {
    _block = block;
}
- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    self.pageControl.hidden = _showPageControl;
}
- (void)setShowViewColor:(UIColor *)showViewColor {
    _showViewColor = showViewColor;
    self.showView.backgroundColor = _showViewColor;
}
- (void)setTextAliment:(HHTextAlignment)textAliment {
    _textAliment = textAliment;
    CGSize size = [_pageControl sizeForNumberOfPages:self.images.count];
    if (_textAliment == HHTextAlignmentRight)
    {
        [_pageControl setFrame:CGRectMake(20, 0, size.width,CGRectGetHeight(_showView.frame))];
        [_textLable setFrame:CGRectMake(CGRectGetMaxX(_pageControl.frame) + 20, 5, KWIDTH - (CGRectGetMaxX(_pageControl.frame)+30), 20)];
        _textLable.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        [_pageControl setFrame:CGRectMake(KWIDTH - size.width - 10, 0, size.width, CGRectGetHeight(_showView.frame))];
        [_textLable setFrame:CGRectMake(10, 5, KWIDTH - CGRectGetMinX(_pageControl.frame) - 30, 20)];
        _textLable.textAlignment = NSTextAlignmentLeft;
    }
}



- (void)refershUI
{
    [self.mySrollerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.images.count == 1)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
        imageView.userInteractionEnabled = YES;
        
        [self.mySrollerView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
        
        [imageView addGestureRecognizer:tap];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView.tag = 100;
        
        self.pageControl.hidden = YES;
        
    }
    else if (self.images.count > 1)
    {
        self.mySrollerView.contentSize = CGSizeMake(KWIDTH * 3, 0);
        _pageControl.numberOfPages = self.images.count;
        for (int index = 0;index < 3 ; index ++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*CGRectGetWidth(self.frame), 0,  CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            
            imageView.userInteractionEnabled = YES;
            
            [_mySrollerView addSubview:imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
            
            [imageView addGestureRecognizer:tap];
            
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            imageView.tag = 100+index;
        }
        [self refersh:0];
        [self setTextAliment:_textAliment];
    }
}
- (void)clicked:(UITapGestureRecognizer *)tap
{
    UIImageView *imgView = (UIImageView *)tap.view;
    NSInteger tapIndex = imgView.tag - 100;
    if (_block) {
        _block(tapIndex);
    }
}
#pragma mark -- Method
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.mySrollerView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.textLable];
        [self.showView addSubview:self.pageControl];
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:self.mySrollerView];
    }
    return self;
}
- (void)config {
    _autoSrollerTimerInterval = 2.0f; //默认两秒
    _autoSroller = NO;                //默认不自动滚动
    _selectIndex = 0;
    _textAliment = HHTextAlignmentRight;

}

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}


//定时器
- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_autoSrollerTimerInterval
                                                      target:self
                                                    selector:@selector(automaticScroll)
                                                    userInfo:nil
                                                     repeats:YES];
    _timer = timer;
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  定时器的方法
 */
- (void)automaticScroll
{
    [self.mySrollerView setContentOffset:CGPointMake(KWIDTH * 2,0)
                            animated:YES];
}

#pragma mark -- UIScrollerView的代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //这些是避免在自动滚动中 由于手动造成的滑动而影响下一个或者前面一个的滚动时间 结束后在加上定时器
    if (_autoSroller)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updatePage];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updatePage];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_autoSroller)
    {
        [self setupTimer];
    }
}
//更新数据
- (void)updatePage{
 
    CGFloat pageWidth = CGRectGetWidth(self.mySrollerView.frame);
    NSInteger currentIndex = self.mySrollerView.contentOffset.x / pageWidth;
    
    if (_mySrollerView.contentOffset.x > pageWidth)
    {
        if (currentIndex ==1) /** < 避免滑动一点点的时候 就去改变数据 > **/
        {
            return;
        }
        NSLog(@"------向左滑动------%ld",currentIndex);
        _selectIndex ++;
        if (_selectIndex > _images.count-1)
        {
            _selectIndex = 0;
        }
    }
    else
    {
        if (currentIndex ==1)
        {
            return;
        }
        NSLog(@"------向右滑动------%ld",currentIndex);
        _selectIndex --;
        if (_selectIndex < 0)
        {
            _selectIndex = _images.count -1;
        }
    }
    [self refersh:_selectIndex];
}

- (void)refersh:(NSInteger)currenIndex
{
    _mySrollerView.contentOffset = CGPointMake(CGRectGetWidth(self.frame) , 0);
    
    if (_titles.count > 0)
    {
        _textLable.text = _titles[currenIndex];
    }
    NSLog(@"------图片------%ld",currenIndex);
    _pageControl.currentPage = currenIndex;
    
    NSArray *array = [self showImageArray:currenIndex];
    
    for (int index = 0; index < [array count]; index++)
    {
        //把需要展示的图片放在imageView上展示
        UIImageView * imgView = _mySrollerView.subviews[index];
        
        if (_isURLImg)
        {
            imgView.image = _placeholderImage;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:array[index]]];
                UIImage *image = [UIImage imageWithData:data];
                
               dispatch_async(dispatch_get_main_queue(), ^{
                   imgView.image = image;
               });
                
            });
            
//            [imgView sd_setImageWithURL:[NSURL URLWithString:array[index]]
//                       placeholderImage:self.placeholderImage];
        }
        else
        {
            imgView.image = [UIImage imageNamed:array[index]];
        }
        
        if (_images.count ==1)
        {
            _mySrollerView.contentSize = CGSizeMake(KWIDTH, 0);
        }
        
    }
    
}
/**
 判断区的数据
 */
// 越界判断 返回正确的数组下标
- (NSInteger)selectIndex:(NSInteger)index
{
    
    if (index < 0) // 最后一张
    {
        index = _images.count-1;
    }
    else if (index > _images.count-1) // 回到第一张
    {
        index = 0;
    }
    
    return index;
}
//获取当前要展示的三张图片
- (NSMutableArray*)showImageArray:(NSInteger)currenIndex
{
    //获取三个图片的下标 当前页面 前一个页面 和后一面的图片的下标
    NSInteger lastIndex  = [self selectIndex:currenIndex -1];
    NSInteger nowIndx    = [self selectIndex:currenIndex];
    NSInteger nextIndx   = [self selectIndex:currenIndex+1];
    
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    
    [arry addObject:_images[lastIndex]];
    [arry addObject:_images[nowIndx]];
    [arry addObject:_images[nextIndx]];
    
    return arry;
}



#pragma mark -- UI界面
- (UIScrollView *)mySrollerView {
    if (!_mySrollerView) {
        _mySrollerView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _mySrollerView.bounces = NO;
        _mySrollerView.pagingEnabled = YES;
        _mySrollerView.showsHorizontalScrollIndicator = NO;
        _mySrollerView.delegate = self;
        _mySrollerView.showsVerticalScrollIndicator = NO;
    }
    return _mySrollerView;
}
- (UIPageControl*)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[HHPageController alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-120, 5, 100, 20)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.alpha = 0.4;
        
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor greenColor];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
    
}
- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT - 30, KWIDTH, 30)];
        _showView.alpha = 0.8;
        _showView.backgroundColor = [UIColor blackColor];
    }
    return _showView;
}
- (UILabel *)textLable {
    if (!_textLable) {
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 30)];
    }
    return _textLable;
}

@end
