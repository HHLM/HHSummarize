//
//  HHCustomPickerView.h
//  HHCustomPickerView
//
//  Created by LXH on 2017/6/16.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHAddressModel.h"

@protocol HHPickerViewDelegate <NSObject>

- (void)pickerViewSelectString:(NSString *)string;

@end

typedef NS_ENUM(NSInteger, HHPickerViewType) {
    HHPickerAddrssType = 0, // 地址
    HHPickerTimeType   = 1, // 时间
};



@interface HHCustomPickerView : UIView


@property (nonatomic, assign) id <HHPickerViewDelegate>delegate;

/**
 展示pickerView

 @param frame 坐标大小
 @param showView 所展示的view
 @return pickerView
 */
- (instancetype)initWithFrame:(CGRect)frame
                     showView:(UIView *)showView;
/**
 展示PickerView 并且刷新数据

 @param type 类型 商圈 地址 时间 ...
 */
- (void)showPickerView:(HHPickerViewType)type;

@end



@interface HHData : NSObject

@property (nonatomic, strong) NSArray *timeArray;

//得到多有省份名称
+ (NSArray *)provices;


@end
