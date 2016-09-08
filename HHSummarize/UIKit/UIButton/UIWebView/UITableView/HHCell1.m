//
//  HHCell1.m
//  UIKit-Demo
//
//  Created by LXH on 15/10/18.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "HHCell1.h"

@implementation HHCell1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
    }
    return self;
}
- (UILabel*)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 69, 20)];
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}
- (UITextField*)field
{
    if (!_field)
    {
        _field = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLab.frame)+10, 10, 69, 20)];
        _field.font = [UIFont systemFontOfSize:14];
    }
    return _field;
}
@end
