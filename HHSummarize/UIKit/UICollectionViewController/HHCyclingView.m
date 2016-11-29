//
//  HHCyclingView.m
//  HHSummarize
//
//  Created by LXH on 2016/11/29.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHCyclingView.h"
#import "HHCyclingCell.h"

@interface HHCyclingView ()<UICollectionViewDelegate,UICollectionViewDataSource>
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 100;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    HHCyclingCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HHCyclingCell class]) forIndexPath:indexPath];
    HHCollectionModel *model = dataArray[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:model.imgName];
    
    return cell;
}
@end
