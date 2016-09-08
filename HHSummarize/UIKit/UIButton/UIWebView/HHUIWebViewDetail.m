//
//  HHUIWebViewDetail.m
//  UIKit-Demo
//
//  Created by LXH on 15/10/4.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "HHUIWebViewDetail.h"

@interface HHUIWebViewDetail ()<UIWebViewDelegate>
{
    UIWebView *webView;
}
@end

@implementation HHUIWebViewDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIWebView详情";
    
    UIBarButtonItem *leftItem1 =
        [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(back)];
    
    leftItem1.tintColor =[UIColor redColor];
    
    self.navigationItem.leftBarButtonItem = leftItem1;
    
    UIBarButtonItem *leftItem =
        [[UIBarButtonItem alloc] initWithTitle:@"前进"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(next)];
    
    leftItem.tintColor =[UIColor redColor];
    
    self.navigationItem.rightBarButtonItem = leftItem;
    
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    
    [self.view addSubview:webView];
    
    webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.html]];
    [webView loadRequest:request];
    

    
}
- (void)back
{
    if([webView canGoBack]) /** < 能返回上一页  > **/
    {
        [webView goBack];
    }
    else /** < 不能返回web的上一页 就返回上个界面 > **/
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    return;
}
- (void)next
{
    [webView reload]; //加载webView
    //同理
    if([webView canGoForward]) /** < 能到web的下一页  > **/
    {
        [webView goForward];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
