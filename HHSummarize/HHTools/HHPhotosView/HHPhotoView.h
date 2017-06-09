//
//  HHPhotoView.h
//  HNNewspaper
//
//  Created by HHL on 16/1/21.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HHPhotoDelegate <NSObject>

- (void)photoAddImage;
- (void)delateImages:(NSArray *)images index:(NSInteger)index;
@end

@interface HHPhotoView : UIView
@property (nonatomic, weak) id  <HHPhotoDelegate> delegate;

- (void)addImage:(NSArray *)images;

@end
