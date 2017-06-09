//
//  HHCyclicView.m
//  HHSummarize
//
//  Created by LXH on 2017/6/9.
//  Copyright © 2017年 HHL. All rights reserved.
//

#define KItemCount  1000 * self.dataArray.count
#define KItemRow    KItemCount/2
#import "HHCyclicView.h"
#import "HHCyclicCell.h"

@interface HHCyclicView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HHCyclicView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataArray.count * 50 inSection:0]  atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self addTimer];
}
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)addTimer
{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextItem) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextItem
{
    NSIndexPath *visiablePath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    NSUInteger visiableItem = visiablePath.item;
    NSLog(@"------:%lu",(unsigned long)visiableItem);
    
    if (visiablePath.item % self.dataArray.count == 0) { // 第0张图片
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataArray.count * 50 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        visiableItem = _dataArray.count * 50;
        NSLog(@"+++++:%lu",(unsigned long)visiableItem);
    }
    
    NSUInteger nextItem = visiableItem + 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count * 100;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    HHCyclicCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HHCyclicCell class]) forIndexPath:indexPath];
    
    cell.imgView.image = [UIImage imageNamed:_dataArray[indexPath.item % _dataArray.count]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSIndexPath *visiablePath = [[collectionView indexPathsForVisibleItems] firstObject];
//    self.pageControl.currentPage = visiablePath.item % self.newses.count;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.width, self.height);
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //水平滑动
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[HHCyclicCell class]
            forCellWithReuseIdentifier:NSStringFromClass([HHCyclicCell class])];
    }
    return _collectionView;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimer];
}
@end
