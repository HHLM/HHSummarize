//
//  HHUICollectionVC.h
//  HHSummarize
//
//  Created by LXH on 2016/11/14.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHBaseVC.h"
#import "HHCollectionViewLayout.h"

@interface HHUICollectionVC : HHBaseVC<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,HHCollectionViewLayoutDelegate>


@end
