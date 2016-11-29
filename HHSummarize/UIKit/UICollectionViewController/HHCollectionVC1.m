//
//  HHCollectionVC1.m
//  HHSummarize
//
//  Created by LXH on 2016/11/29.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHCollectionVC1.h"
#import "HHCollectionCell.h"
#import "HHCyclingView.h"
static CGFloat const ADHeigth = 200;
@interface HHCollectionVC1 ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HHCyclingView *headView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HHCollectionVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 9; i ++) {
        HHCollectionModel *model = [[HHCollectionModel alloc] init];
        model.imgName = [NSString stringWithFormat:@"%d.jpg",i];
        model.title = [NSString stringWithFormat:@"标题%d",i];
        [_dataArray addObject:model];
    }
    self.headView.imageArray = _dataArray;
}

#pragma mark -- UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    HHCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HHCollectionCell" forIndexPath:indexPath];
    [cell sizeToFit];
    HHCollectionModel *model = _dataArray[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:model.imgName];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    [headerView addSubview:self.headView];//头部广告栏
    return headerView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView ) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        //头部大小
        layout.headerReferenceSize = CGSizeMake(self.view.width, ADHeigth);
        
        //item的大小
        layout.itemSize = CGSizeMake(HWIDTH/2 - 10, HWIDTH/2 - 10 + 40);
        
         //定义每个UICollectionView 横向的间距
        layout.minimumLineSpacing = 5;
        
        //定义每个UICollectionView 纵向的间距
        layout.minimumInteritemSpacing = 2;
        
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
        
        _collectionView = [[UICollectionView alloc]  initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //注册cell
        [_collectionView registerClass:[HHCollectionCell class] forCellWithReuseIdentifier:@"HHCollectionCell"];
        
        //注册头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    }
    return _collectionView;
}
- (HHCyclingView *)headView {
    if (!_headView) {
        _headView = [[HHCyclingView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ADHeigth)];
        _headView.backgroundColor = [UIColor redColor];
    }
    return _headView;
}
@end
