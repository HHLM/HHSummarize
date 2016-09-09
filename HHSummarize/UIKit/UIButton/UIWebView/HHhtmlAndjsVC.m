//
//  HHhtmlAndjsVC.m
//  UIKit-Demo
//
//  Created by HHL on 15/12/1.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "HHhtmlAndjsVC.h"
#import "HHUIWebViewAndJS.h"
@interface HHhtmlAndjsVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UITextField *text2;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HHhtmlAndjsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"JS交互";
    UIBarButtonItem *leftItem =
    [[UIBarButtonItem alloc] initWithTitle:@"下一页"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(next)];
    
    leftItem.tintColor =[UIColor redColor];
    
    self.navigationItem.rightBarButtonItem = leftItem;
    
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    NSString *helpHtmlPath = [basePath stringByAppendingPathComponent:@"test.html"];
    NSURL *url = [NSURL fileURLWithPath:helpHtmlPath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}
- (void)next
{
    HHUIWebViewAndJS *jsVc = [[HHUIWebViewAndJS alloc] init];
    [self.navigationController pushViewController:jsVc animated:YES];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlString=%@",urlString);
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"objc"])
    {
        
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":/"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        
        if (1 == [arrFucnameAndParameter count])
        {
            // 没有参数
            if([funcStr isEqualToString:@"doFunc1"])
            {
                
                /*调用本地函数1*/
                NSLog(@"doFunc1");
                
            }
        }
        else
        {
            //有参数的
            if([funcStr isEqualToString:@"getParam1:withParam2:"])
            {
                [self getParam1:[arrFucnameAndParameter objectAtIndex:1] withParam2:[arrFucnameAndParameter objectAtIndex:2]];
            }
        }
        return NO;
    }
    return TRUE;

}
-(void)getParam1:(NSString*)str1 withParam2:(NSString*)str2
{
    //    NSLog(@"收到html传过来的参数：str1=%@,str2=%@",str1,str2);
    NSString *str = [NSString stringWithFormat:@"收到html传过来的参数：str1=%@,str2=%@",str1,str2];
    [[[UIAlertView alloc] initWithTitle:@""
                                message:str
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil]  show];
}
- (IBAction)chageClick:(id)sender
{
    NSString *str1 = self.text1.text;
    NSString *str2 = self.text2.text;
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"changeText(%@,%@);",str1,str2]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
