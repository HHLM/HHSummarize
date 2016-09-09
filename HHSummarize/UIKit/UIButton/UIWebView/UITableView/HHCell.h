//
//  HHCell.h
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHCellView.h"
#import "HHModel.h"

typedef void (^Clicked)(NSInteger index);

@interface HHCell : UITableViewCell

@property (nonatomic, copy)   Clicked block;
@property (nonatomic, assign, readonly)CGFloat cellHight;/** < cell的高度 > **/

@property (nonatomic, strong) HHCellView *FirstView;
@property (nonatomic, strong) HHCellView *SecondView;
@property (nonatomic, strong) HHCellView *Thirdiew;

- (void)selectCellView:(Clicked)cellBlock;

- (void)refershCell:(NSArray*)array;/** < 刷新cell的页面 > **/

- (void)dataArray:(NSMutableArray*)dataArr
        indexPath:(NSIndexPath*)indexPath;/** < 处理数组 > **/
@end
