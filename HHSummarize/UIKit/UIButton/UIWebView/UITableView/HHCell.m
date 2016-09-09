//
//  HHCell.m
//  HHSummarize
//
//  Created by LXH on 16/9/8.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHCell.h"
#import "HHModel.h"
@implementation HHCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.frame));
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat WIDTH = CGRectGetWidth(self.frame);
        
        CGFloat x     = 10;
        CGFloat width = (WIDTH-x)/3;
        CGFloat wid   = width - x; /** < 每个cellview的宽度 > **/
        
        
        for (int i = 0; i < 3; i ++)
        {
            HHCellView *view = [[HHCellView alloc] initWithFrame:CGRectMake(x+i*width, 0, wid, 160)];
            [self addSubview:view];
            view.tag = 100+i;
            [view addTarget:self
                     action:@selector(clickedCellView:)
           forControlEvents:UIControlEventTouchUpInside];
            
            _cellHight = view.heigh;
            switch (i)
            {
                case 0:
                    self.FirstView  = view;
                    break;
                case 1:
                    self.SecondView = view;
                    break;
                case 2:
                    self.Thirdiew   = view;
                    break;
                    
                default:
                    break;
            }
        }
    }
    return self;
}
- (void)clickedCellView:(UIControl*)control
{
    if (self.block)
    {
        self.block(control.tag - 100);
    }
    
}
- (void)selectCellView:(Clicked)cellBlock
{
    self.block = [cellBlock copy];/** < 拷贝block > **/
}
/** < 每个cell数据处理 > **/
- (void)refershCell:(NSArray *)array
{
    if (array.count < 3)
    {
        switch (array.count%3)
        {
            case 1:
            {
                [self.FirstView setHidden:NO];
                [self.FirstView model:array[0]];
                [self.SecondView setHidden:YES];
                [self.Thirdiew setHidden:YES];
            }
                break;
            case 2:
            {
                [self.FirstView setHidden:NO];
                [self.FirstView model:array[0]];
                [self.SecondView setHidden:NO];
                [self.SecondView model:array[1]];
                [self.Thirdiew setHidden:YES];
            }
                break;
            default:
                break;
        }
    }
    else
    {
        self.FirstView.hidden = NO;
        [self.FirstView model:array[0]];
        self.SecondView.hidden = NO;
        [self.SecondView model:array[1]];
        self.Thirdiew.hidden = NO;
        [self.Thirdiew model:array[2]];
    }

}
- (void)dataArray:(NSMutableArray*)dataArray indexPath:(NSIndexPath*)indexPath
{
    NSMutableArray *array = [NSMutableArray array];
    
    if (dataArray.count < (indexPath.row+1)*3)
    {
        for (int i = 0; i < dataArray.count%3; i++)
        {
            [array addObject:dataArray[i+indexPath.row*3]];
        }
    }
    else
    {
        for (int i = 0; i < 3; i++)
        {
            [array addObject:dataArray[i+indexPath.row*3]];
        }
    }
    [self refershCell:array];
    
}

@end
