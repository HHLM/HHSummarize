//
//  HHUIWebViewFile.m
//  UIKit-Demo
//
//  Created by LXH on 15/10/3.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "HHUIWebViewFile.h"
#import "HHhtmlAndjsVC.h"
@interface HHUIWebViewFile ()<UIWebViewDelegate>
{
    UIWebView *webView1;
}
@end

@implementation HHUIWebViewFile

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem =
    [[UIBarButtonItem alloc] initWithTitle:@"下一页"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(next)];
    
    leftItem.tintColor =[UIColor redColor];
    
    self.navigationItem.rightBarButtonItem = leftItem;
    
    webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.view addSubview:webView1];
    webView1.delegate = self;
    [self.view addSubview:webView1];
    [self showFile];
    
}
- (void)next
{
    HHhtmlAndjsVC *vc = [[HHhtmlAndjsVC alloc] initWithNibName:@"HHhtmlAndjsVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
//读取本地文件
- (NSString*)showFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"jeep_1"]
                                                     ofType:@"txt"];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    
    NSData *data = [fileHandle readDataToEndOfFile];
    
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"打印文本数据：%@",text);

    
    //webView加载txt文件
    [webView1 loadData:data MIMEType:@"text/plain" textEncodingName:@"UTF-8" baseURL:nil];
    
#if 0
     NSString  *htmlString = [NSString stringWithFormat:@"<body style=\"background-color: white;margin-right:20px;margin-left:16px;\">"];//设置背景ht颜色

     [webView1 loadHTMLString:[NSString stringWithFormat:@"%@%@",htmlString,text] baseURL:nil];
#endif
    
    //webview透明
    [webView1 setBackgroundColor:[UIColor clearColor]];
    [webView1 setOpaque:NO];
    
    return text;
}

#pragma mark -- webView加载本地数据
- (void)loadWebview
{
    //webview加载本地文件，可以使用加载数据的方式
    NSString *path = [[NSBundle mainBundle] pathForResource:@"关于.docx" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //相对地址，一般加载本地文件不使用，可以在指定的baseURL中查找相关文件。
    NSLog(@"%@", [self mimeType:url]);
    
    
    //以二进制数据的形式加载沙箱中的文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    //第一个诶参数是一个NSData， 本地文件对应的数据
    //第二个参数是MIMEType
    //第三个参数是编码格式
    
    
    //webView加载txt文件
    [webView1 loadData:data MIMEType:@"text/plain" textEncodingName:@"UTF-8" baseURL:nil];
    
    //webView加载docx文件
    [webView1 loadData:data MIMEType:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document" textEncodingName:@"UTF-8" baseURL:nil];
    
    //webView加载pdf文件
    [webView1 loadData:data MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:nil];
    
    //webview透明
    [webView1 setBackgroundColor:[UIColor clearColor]];
    [webView1 setOpaque:NO];
}

#pragma mark 获取指定URL的MIMEType类型
- (NSString *)mimeType:(NSURL *)url
{
    //1NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //2NSURLConnection
    
    //3 在NSURLResponse里，服务器告诉浏览器用什么方式打开文件。
    
    //使用同步方法后去MIMEType
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}
#pragma mark -- UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    /*
     让webview的高度跟内容高度一样
     */
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = [webView frame];
    frame.size.height = [string floatValue] + 5;
//    [webView setFrame:frame];
    
    NSLog(@"%f",frame.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
