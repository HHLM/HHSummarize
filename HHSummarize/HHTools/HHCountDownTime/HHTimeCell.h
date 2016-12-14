//
//  HHTimeCell.h
//  HHCountDownTime
//
//  Created by LXH on 16/7/28.
//  Copyright © 2016年 LXH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,TimeType) {
    TimeEndType = 0,
    TimeBeginType = 1
};

@interface HHTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLab;
+ (instancetype)creatCellWithTabelView:(UITableView *)tabelView;
- (void)refershCell:(NSString *)timeString type:(TimeType )type;
@end
