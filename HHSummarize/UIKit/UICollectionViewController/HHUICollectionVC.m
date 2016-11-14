//
//  HHUICollectionVC.m
//  HHSummarize
//
//  Created by LXH on 2016/11/14.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHUICollectionVC.h"
#import "HHCollectionViewCell.h"
@interface HHUICollectionVC ()

@end

@implementation HHUICollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    HHCollectionViewLayout *layout = [[HHCollectionViewLayout alloc] init];
    layout.delegate = self;
    layout.columnCount = 3;
    layout.itemWidth = self.view.frame.size.width/3 - 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.footerReferenceSize =CGSizeMake(self.view.frame.size.width, 30);
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, HWIDTH, HHEIGHT - 64) collectionViewLayout:layout];
    
    collectionView.delegate =  self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor greenColor];
    
    [collectionView registerClass:[HHCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
    
}
// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableView = header;
    }
    reusableView.backgroundColor = [UIColor greenColor];
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerview.backgroundColor = [UIColor purpleColor];
        reusableView = footerview;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(140, arc4random() % 200 + 100);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(HHCollectionViewLayout *)collectionViewLayout heigthForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return arc4random() % 100 + 50;
}



@end
