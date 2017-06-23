//
//  HHAddressModel.h
//  HHCustomPickerView
//
//  Created by LXH on 2017/6/21.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HHAddressModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSArray <HHAddressModel *> *cityArray;


@end

