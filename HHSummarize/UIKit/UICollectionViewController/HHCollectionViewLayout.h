//
//  HHCollectionViewLayout.h
//  HHSummarize
//
//  Created by LXH on 2016/11/14.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHCollectionViewLayout;

@protocol HHCollectionViewLayoutDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(HHCollectionViewLayout *)collectionViewLayout
 heigthForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HHCollectionViewLayout : UICollectionViewLayout


@property (nonatomic, weak) id <HHCollectionViewLayoutDelegate> delegate;

/** 列数 */
@property (nonatomic, assign) NSUInteger columnCount;

/** item的宽度 */
@property (nonatomic, assign) CGFloat itemWidth;;

/** 每个sectionInset的间距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) CGSize footerReferenceSize;

@end
