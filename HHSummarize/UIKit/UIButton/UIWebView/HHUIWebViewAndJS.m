//
//  HHUIWebViewAndJS.m
//  HHSummarize
//
//  Created by LXH on 16/9/9.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHUIWebViewAndJS.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface HHUIWebViewAndJS ()<UIWebViewDelegate>
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) UIWebView *detailWeb;
@end

@implementation HHUIWebViewAndJS

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.detailWeb];
    [self.detailWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://read.hnzxcm.com/appread/?userid=19D63D0F9B9B664Ebarlist?userid=19D63D0F9B9B664E"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    _context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        
    };
    
    _context[@"share"]=
    ^(NSString *str)
    {
        DLog(@"分享页面");
    };
    
    _context[@"urlshare"] = ^(NSString *url,NSString *title ,NSString *note,NSString *images){
        DLog(@"分享页面");
    };
    

    
    
    //获取页面的代码body的内容：
    NSString *JsToGetHTMLSource = @"document.body.innerHTML";
    NSString *pageSource = [webView stringByEvaluatingJavaScriptFromString:JsToGetHTMLSource];
    NSLog(@"pagesource:%@", pageSource);
    //获取标题
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setTitle:title];
    
    // 禁用用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用长按弹出框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    // 隐藏titleBar
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('titlebar').style.display = 'none';"];
    
    NSString *backUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('back').href"];
    DLog(@"%@",backUrl);
}

- (UIWebView *)detailWeb {
    if (!_detailWeb) {
        _detailWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, HWIDTH, HHEIGHT - 64)];
    }
    return _detailWeb;
}
@end
