//
//  HHCyclingView.m
//  HHSummarize
//
//  Created by LXH on 2016/11/29.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHCyclingView.h"
#import "HHCyclingCell.h"

@interface HHCyclingView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    NSArray *dataArray;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation HHCyclingView

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
- (void)setImageArray:(NSArray *)imageArray {
    dataArray = imageArray;
    [self.collectionView reloadData];
    NSIndexPath *path = [NSIndexPath indexPathForItem:dataArray.count * 5 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path  atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.width, self.height);
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
//        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[HHCyclingCell class]
            forCellWithReuseIdentifier:NSStringFromClass([HHCyclingCell class])];
        
        
    }
    return _collectionView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArray.count * 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    HHCyclingCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HHCyclingCell class]) forIndexPath:indexPath];
    HHCollectionModel *model = dataArray[indexPath.item % dataArray.count];
    cell.imgView.image = [UIImage imageNamed:model.imgName];
    cell.titleLab.text = [NSString stringWithFormat:@"%ld",(indexPath.item % dataArray.count)];
    
    return cell;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSArray *indexPaths = _collectionView.indexPathsForVisibleItems;
    NSIndexPath *path = indexPaths.firstObject;
    DLog(@"section:%ld----row:%ld",(long)path.section,(long)path.item);
    if (path.item % dataArray.count == 0) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:dataArray.count* 5 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path  atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        NSInteger count = dataArray.count * 5;
        DLog(@"+++++++%ld",count);
    }
}
@end
