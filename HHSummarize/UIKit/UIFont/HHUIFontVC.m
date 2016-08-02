//
//  HHUIFontVC.m
//  HHSummarize
//
//  Created by LXH on 16/8/2.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHUIFontVC.h"

@interface HHUIFontVC ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation HHUIFontVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"VC" withString:@""];
    // Do any additional setup after loading the view from its nib.
    [self fontName];
    self.label1.text = @"1.将xx.ttf字体库加入工程里面2.在工程的xx-Info.plist文件中新添加一行Fonts provided by application，加上字体库的名称";
    self.label2.text = @"1.将xx.ttf字体库加入工程里面2.在工程的xx-Info.plist文件中新添加一行Fonts provided by application，加上字体库的名称";
    self.label2.font = [UIFont fontWithName:@"FZYaSong-M-GBK" size:17];
}

- (void)fontName
{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames )
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames )
        {
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}

@end
