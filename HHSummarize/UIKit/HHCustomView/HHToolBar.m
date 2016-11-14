//
//  HHToolBar.m
//  推送
//
//  Created by LXH on 2016/11/7.
//  Copyright © 2016年 HHLM. All rights reserved.
//

#import "HHToolBar.h"

@implementation HHToolBar
{
    id actionTarget;
    SEL cancleActionSelector, doneActionSelector;
    UISegmentedControl *segmented;
    UIBarButtonItem *doneButton;
}

- (instancetype )initWithTarget:(id)target canCelAction:(SEL)canCelAction  doneAction:(SEL)doneAction;
{
    self = [super init];
    if (self)
    {
        actionTarget         = target;
        cancleActionSelector = canCelAction;
        doneActionSelector   = doneAction;
        [self load];
    }
    return self;
}
-(void)load
{
    CGRect rect = CGRectMake(0 ,0,[UIScreen mainScreen].bounds.size.width, 44);
    rect.size.height = 44.f;
    self.frame = rect;
    self.barStyle = UIBarStyleDefault;
    self.tintColor = UIColor.blackColor;
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:actionTarget action:nil];
    
    UIBarButtonItem  *doneButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:actionTarget action:doneActionSelector];
    
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                  style:UIBarButtonItemStylePlain
                                                 target:actionTarget
                                                 action:doneActionSelector];
   
    doneButton.tintColor = [UIColor orangeColor];
    doneButton1.tintColor = [UIColor orangeColor];
    
    self.items = @[doneButton1,btnSpace,doneButton];
}

@end
