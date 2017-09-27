//
//  HHUIWebView.m
//  UIKit-Demo
//
//  Created by LXH on 15/10/3.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "HHUIWebViewVC.h"
#import "HHUIWebViewFile.h"
#import "HHUIWebViewDetail.h"
//#import "SDPhotoBrowser.h"
@interface HHUIWebViewVC ()<UIWebViewDelegate>
{
    UIWebView       *web ;
    UIView          *bgView;
    UIImageView     *imgView;
    NSString        *html_str;
    NSMutableArray  *imageArray;
}
@end

@implementation HHUIWebViewVC


- (void)viewDidLoad
{
    
    
    imageArray = [NSMutableArray array];
    
    [self config];
    [self html1];
    
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    web.delegate = self;
    
    NSString *temstr=@"<style type=\"text/css\">img{max-width:100%;height:auto;} </style>";//只要是img标签都限定大小
    
    //任何(*)标签都设置字体--本项目用的标签基本都是<p>,所以可以把*改成p
    
    /** < 字号大小16  字体颜色 ：绿色> **/
    NSString *fontString = [NSString stringWithFormat:@"<style type=\"text/css\">*{font-size:%0.0fpx; color:green} </style>",16.0];
    
    /** < 距离左右边距16 背景颜色白色 > **/
    NSString *str = [NSString stringWithFormat:@"<body style=\"background-color: white;margin-right:16px;margin-left:16px;;\">"];
    
    //设置背景颜色
    NSString *htmlString1 = [NSString stringWithFormat:@"%@%@%@%@", temstr, fontString, html_str,str];//设置大小
    [self title:html_str];
    [self imageURL:html_str];
    
    [web loadHTMLString:htmlString1 baseURL:nil];
    web.scrollView.bounces = NO;
    web.scrollView.showsVerticalScrollIndicator = YES;
    
    [self.view addSubview:web];

}
- (void)config
{
    self.title = @"UIWebView 加载HTML";
    UIBarButtonItem *leftItem =
        [[UIBarButtonItem alloc] initWithTitle:@"下一页"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(next)];
    
    leftItem.tintColor =[UIColor redColor];

    self.navigationItem.rightBarButtonItem = leftItem;
    
    
    
    
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}


#pragma mark -- UIWebView的代理
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
#pragma mark -- UIWebView的代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //调整字号
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '95%'";
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    //js方法遍历图片添加点击事件 返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return objs.length;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    
    
    //获取所有的图片
    NSString *imageURLs = [webView stringByEvaluatingJavaScriptFromString:[self createImgArrayJavaScript]];//注入js方法
    
    NSLog(@"图片的连接地址:%@",imageURLs);
    
    
    [imageArray setArray:[imageURLs componentsSeparatedByString:@";"]];
    for (NSString *url in imageArray)
    {
        if (url.length == 0)
        {
            [imageArray removeObject:url];
        }
    }
    
    NSLog(@"图片的连接地址imageArray:%@",imageArray);
    
    //注入自定义的js方法后别忘了调用    否则不会生效（不调用也一样生效了，，，不明白）
    NSString *imageCount = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    
    //调用js方法
        NSLog(@"---调用js方法--%@  图片的个数：%s  jsMehtods_result = %@",self.class,__func__,imageCount);
    
    //获取JS的页面的数据
    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
    
    NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
    NSLog(@"页面的文字内容:%@",HTMLSource);
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if ([request.mainDocumentURL.relativePath isEqualToString:@"/alert"])
    {
        //iOS9 以后不能这样用
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"本地代码执行"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        return NO;
        //执行本地代码，返回NO不让网页读取网络资源
    }
    
         NSLog(@"%@",request.URL.absoluteString);
    
    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
    
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"])
    {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        
        
        
        for (int i= 0; i < imageArray.count; i++)
        {
            if ([imageUrl isEqualToString:[imageArray objectAtIndex:i]])
            {
#if 0
                /** < 展示图片 > **/
                SDPhotoBrowser* browser = [[SDPhotoBrowser alloc] init];
                browser.sourceImagesContainerView = self.view; // 原图的父控件
                browser.imageCount = imageArray.count; // 图片总数
                browser.currentImageIndex = i;
                browser.delegate = self;
                [browser show];
#else
                 //iOS9 以后用法
                NSLog(@"点击图片第%d张图片---图片URL: %@",i,imageUrl);
                NSString *str = [NSString stringWithFormat:@"点击图片%d 图片URL: %@",i,imageUrl];
               UIAlertController *alertController =
                [UIAlertController alertControllerWithTitle:@"点击图片"
                                                     message:str
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction =
                [UIAlertAction actionWithTitle:@"取消"
                                         style:UIAlertActionStyleCancel
                                       handler:nil];
                
                UIAlertAction *okAction =
                [UIAlertAction actionWithTitle:@"好的"
                                         style:UIAlertActionStyleDefault
                                       handler:nil];
                
                [alertController addAction:cancelAction];
                [alertController addAction:okAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
#endif
            }
        }
        
        return NO;
    }
    else
    {
        if ([request.URL.absoluteString hasPrefix:@"http"] || [request.URL.absoluteString hasPrefix:@"HTTP"])
        {
            HHUIWebViewDetail *webDetail = [[HHUIWebViewDetail alloc] init];
            webDetail.html = request.URL.absoluteString;
            [self.navigationController pushViewController:webDetail  animated:YES];
            return NO;
        }
        else
        {
            return YES;
        }

    }
    return YES;
}

//- (UIImage*)photoBrowser:(SDPhotoBrowser*)browser placeholderImageForIndex:(NSInteger)index
//{ /** < 默认图片 > **/
//    return nil;
//}
//
//// 返回高质量图片的url
//- (NSURL*)photoBrowser:(SDPhotoBrowser*)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    
//    NSString *urlStr = [imageArray[index] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//    
//    return [NSURL URLWithString:urlStr];
//}

//获取web里的所有的img url
- (NSString *)createImgArrayJavaScript
{
    NSString *js =
    @"var imgArray = \
    document.getElementsByTagName('img');\
    var imgstr = ''; \
    function f()\
    { for(var i = 0; i < imgArray.length; i++)\
    { imgstr += imgArray[i].src;imgstr += ';';} \
    return imgstr; } \
    f();";
    
    return js;
}

//返回web img图片的数量
- (NSString *)createGetImgNumJavaScript
{
    NSString *js = @"var imgArray = \
    document.getElementsByTagName('img');\
    function f()\
    { var num=imgArray.length;return num;}\
    f();";
    return js;
}
- (void)next
{
    HHUIWebViewFile *webFile = [[HHUIWebViewFile alloc] init];
    [self.navigationController pushViewController:webFile animated:YES];
}

#pragma mark -- 处理图片和文字
- (void)title:(NSString*)htmlString
{
    NSMutableArray *titleArray = [NSMutableArray array];
    NSRange resultRange = NSMakeRange(0, 0);
    do
    {
        resultRange = [htmlString rangeOfString:@"<img.*?>" options:NSRegularExpressionSearch range:NSMakeRange(resultRange.location + resultRange.length, htmlString.length - resultRange.location - resultRange.length)];
        if (resultRange.length != 0)
        {
            NSString *imageString = [htmlString substringWithRange:resultRange];
            NSRange imageRange;
            imageRange.location = 0;
            imageRange.length = imageString.length;
            imageRange = [imageString rangeOfString:@"alt" options:NSCaseInsensitiveSearch range:imageRange];
            imageRange.location = imageRange.location + imageRange.length;
            imageRange.length = imageString.length - imageRange.location;
            
            NSString *srcString = [imageString substringWithRange:imageRange];
            imageRange.location = 0;
            imageRange.length = srcString.length;
            NSRange srcBeginRange = [srcString rangeOfString:@"\"" options:NSCaseInsensitiveSearch range:imageRange];
            
            if (imageRange.length > 2)
            {
                imageRange.location = srcBeginRange.location + 1;
                imageRange.length = srcString.length - imageRange.location;
            }
            
            NSRange srcEndRange = [srcString rangeOfString:@"\"" options:NSCaseInsensitiveSearch range:imageRange];
            if (srcBeginRange.length > 0 && srcEndRange.length > 0)
            {
                imageRange.location = srcBeginRange.location + srcBeginRange.length;
                imageRange.length = srcEndRange.location - imageRange.location;
                srcString = [srcString substringWithRange:imageRange];
                [titleArray addObject:srcString];
            }
            
        }
    }
    while (resultRange.length != 0);
}
- (void)imageURL:(NSString*)htmlString
{
    NSMutableArray *titleArray = [NSMutableArray array];
    NSRange resultRange = NSMakeRange(0, 0);
    do
    {
        resultRange = [htmlString rangeOfString:@"<img.*?>"
                                        options:NSRegularExpressionSearch
                                          range:NSMakeRange(resultRange.location + resultRange.length, htmlString.length - resultRange.location - resultRange.length)];
        if (resultRange.length != 0)
        {
            NSString *imageString = [htmlString substringWithRange:resultRange];
            NSRange imageRange;
            imageRange.location = 0;
            imageRange.length = imageString.length;
            imageRange = [imageString rangeOfString:@"src"
                                            options:NSCaseInsensitiveSearch
                                              range:imageRange];
            
            imageRange.location = imageRange.location + imageRange.length;
            imageRange.length = imageString.length - imageRange.location;
            
            NSString *srcString = [imageString substringWithRange:imageRange];
            imageRange.location = 0;
            imageRange.length = srcString.length;
            NSRange srcBeginRange = [srcString rangeOfString:@"\""
                                                     options:NSCaseInsensitiveSearch
                                                       range:imageRange];
            
            if (imageRange.length > 2)
            {
                imageRange.location = srcBeginRange.location + 1;
                imageRange.length = srcString.length - imageRange.location;
            }
            
            NSRange srcEndRange = [srcString rangeOfString:@"\""
                                                   options:NSCaseInsensitiveSearch
                                                     range:imageRange];
            
            if (srcBeginRange.length > 0 && srcEndRange.length > 0)
            {
                imageRange.location = srcBeginRange.location + srcBeginRange.length;
                imageRange.length = srcEndRange.location - imageRange.location;
                srcString = [srcString substringWithRange:imageRange];
                [titleArray addObject:srcString];
            }
            
        }
    }
    while (resultRange.length != 0);
}

- (void)html1 {
    html_str = @"<!doctype html><html><head><meta charset=\"utf-8\" /><meta name=\"format-detection\" content=\"telephone=no\"><meta http-equiv=\"Cache-Control\" content=\"no-siteapp\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"><title>好食期</title><meta name=\"description\" content=\"好食期是一个专门做食品特卖的电商平台\"><meta name=\"full-screen\" content=\"yes\"/></head><body><style>    body, html {      width: 100%;      margin: 0;    }    body {      -webkit-user-select: none;    }    *{      -webkit-appearance:none;appearance:none;outline:none;      -webkit-tap-highlight-color:rgba(0,0,0,0);    }    .detail-tap {    }    .detail-tap-content {      background: #fff;    }    .tap-title {      float: left;      width: 50%;      height: 45px;      padding-bottom: 1px;      line-height: 45px;      text-align: center;      background: #fff;      border-bottom: 1px solid #dbdbdb;    }    .detail-service, .detail-img {      background: #fff;      border-top: 10px solid #f1f1f1;      list-style: none;      padding-left: 0;      clear: both;    }    .service-title ~ .detail-service {      display: none;    }    .tap-title.active {      padding-bottom: 0px;      color: #ff5555;      border-bottom: 2px solid #ff5555;    }    .service-title.active ~ .detail-img {      display: none;    }    .service-title.active ~ .detail-service {      display: block;    }    .detail-service li {      position: relative;      padding: 10px;      padding-left: 15px;      border-top: 1px solid #dbdbdb;    }    .detail-service li:after {      content: "";      position: absolute;      top: 18px;      left: 5px;      width: 4px;      height: 4px;      border-radius: 2px;      background: #ff5555;    }    .detail-service li b {      display: block;      padding-bottom: 5px;      color: #373737;    }    .detail-service li span {      color: #acacac;      font-size: 12px;    }</style><div class=\"detail-tap\"><div class=\"detail-tap-content J_detail_content\"><div class=\"tap-title img-title active J_tap_1\">图文详情</div><div class=\"tap-title service-title J_tap_2\">服务保障</div><div class=\"detail-img\">        <img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/ma7cd0f16beedc1300951d187c926d4237\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/ma71a5cdf97eda01ed5fb58e402ef8668f\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/ma95c7a9058d4c0c1035fd8505cf9bfa92\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/mad936f7260bca1fcdcdbe64186ea72c9a\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/maabb0062e2c94021b8c97a16697d5e2cc\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/ma1e5d7d8e90dd2113b02bd151338509a5\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/ma388e774651d9789bd734fc9fe6e64e02\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/madca43da94183bc58d1f731ff3e3c4de2\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/ma71d4f2e382cb5644cb17f613af00731b\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/ma2371e78e462fa667c900ed9d2c65ae92\" style=\"width:100%;\"/><img src=\"http://img.haoshiqi.net/merchantadmin/image20161103/ma2b966af3b976b22bf261ba135759f930\" style=\"width:100%;\"/></div><ul class=\"detail-service\"><li><b>100%正品</b><span>所有商家均经过严格资质审核，请放心购买</span></li><li><b>售后保障</b><span>商品存在质量问题，可立即申请退款<br>质量问题包括：保质期不符、食品损坏、变质、包装损坏等</span></li><li><b>发货承诺</b><span>商家将在承诺时间内发货<br>（每个商家承诺时间不同，具体请在商品详情页查看）</span></li><li><b>PICC安全保障</b><span>您购买的每一件商品都由中国人民保险集团股份有限公司（PICC）为您承保</span></li><li><b>标示价格说明</b><span>被划去的“价格”指国内大陆地区知名的主流电商平台，同品牌同种等量规格商品，在本商品上架同时的标示价格，或厂家、供应商指导价，商品实际售价为本平台实时销售价格<br><br>“单独购”为拼团产品中1人单买价格，“X人团”为拼团产品中多人（人数大于或等于2人）拼团购买价格</span></li></ul></div></div><script type=\"text/javascript\">    (function(){      var _ = function(selector) {        return document.querySelector(selector);      };      function switchTap(obj) {        var activeObj = obj.parentNode.querySelector(\".active\");        activeObj.className = activeObj.className.replace(\" active\", "");        obj.className += \" active\";      }      setTimeout(function(){        [_(\".J_tap_1\"), _(\".J_tap_2\")].forEach(function(obj, index) {          obj.onclick = function() {            switchTap(this);          };        });      }, 500);    })();</script></body></html>";
}
- (void)html
{
    html_str = @"<p style=\"line-height:150%;letter-spacing: 1px; word-spacing: 2px;text-align:justify;\"></p><p style=\"line-height:150%;letter-spacing: 1px; word-spacing: 2px;text-align:justify;\"><br style=\"text-align:left;\" /></p><p style=\"line-height:150%;letter-spacing: 1px; word-spacing: 2px;text-align:justify;\"></p><center style=\"font-style:normal;font-variant:normal;font-weight:normal;font-size:14px;line-height:26px;font-family:arial, helvetica, sans-serif;margin:0px;padding:0px;color:#666666;text-transform:none;text-indent:28px;letter-spacing:normal;word-spacing:0px;font-stretch:normal;-webkit-text-stroke-width:0px;text-align:left;\"><center style=\"margin:0px;padding:0px;text-align:left;\"><img style=\"margin:0px;padding:0px;border:currentcolor;position:relative;float:left;\" id=\"9580514\" border=\"0\" alt=\"惨无人道！“博科圣地”残忍杀害正在分娩女性\" src=\"http://world.chinadaily.com.cn/img/attachement/jpg/site1/20150115/eca86bd9d8db1621b26402.JPG\" sourcename=\"本地文件\" sourcedescription=\"编辑提供的本地文件\" /><img style=\"margin:0px;padding:0px;border:currentcolor;position:relative;float:left;\" id=\"9580514\" border=\"0\" alt=\"惨无人道！“博科圣地”残忍杀害正在分娩女性\" src=\"http://imgsrc.baidu.com/forum/pic/item/a38e4566d0160924139b6cd9d40735fae7cd342d.jpg\" sourcename=\"本地文件\" sourcedescription=\"编辑提供的本地文件\" /></center><center style=\"margin:0px;padding:0px;text-align:justify;\">“国际特赦组织”发布的卫星图片显示，尼日利亚北部两个小镇在“博科圣地”的袭击中几乎被夷为平地。（图片来源：法新社）</center></center><p style=\"line-height:150%;letter-spacing: 1px; word-spacing: 2px;text-align:justify;\">中国日报网1月15日电（张同彤）据法新社1月15日报道，“国际特赦组织”（Amnesty International）15日发表报告称，尼日利亚极端组织“<a style=\"margin:0px;padding:0px;color:#111111;text-decoration:none;\" href=\"http://world.chinadaily.com.cn/2015-01/10/content_19286711.htm\" target=\"_blank\">博科圣地</a>”本月上旬在该国东北部发动的袭击中，残忍地杀害了一名正在分娩的女性。报告称，此次袭击可能是“博科圣地”在<a style=\"margin:0px;padding:0px;color:#111111;text-decoration:none;\" href=\"http://world.chinadaily.com.cn/2015-01/12/content_19298165.htm\" target=\"_blank\">尼日利亚</a>活动6年来发动的最惨烈的袭击，造成大量无辜平民伤亡。</p><p style=\"line-height:150%;letter-spacing: 1px; word-spacing: 2px;text-align:justify;\">“国际特赦组织”援引当地幸存目击者的证言称，“博科圣地”在位于尼日利亚东北部的博尔诺州的巴格镇发起袭击，对无辜平民进行扫射时，子弹击中了一名正在分娩的女性。当时“她的孩子——一名男孩已经有一半身体露出来。”</p><p style=\"line-height:150%;letter-spacing: 1px; word-spacing: 2px;text-align:justify;\">武装分子大肆杀害当地居民，包括儿童在内。巴格镇大屠杀的幸存者称该镇横尸遍野。尽管军方发言人称死亡总人数不超过150人，但是“国际特赦组织”称，有报告显示，此次屠杀造成的死亡人数可高达2000人。由于目前巴格镇和周边地区还在武装分子的控制之中，无法统计遇难者的确切人数。</p><p style=\"line-height:150%;letter-spacing: 1px; word-spacing: 2px;text-align:justify;\">报道称，武装分子在屠杀平民后，还几乎烧毁了镇上的所有房屋。“国际特赦组织”发布了巴格镇及距其2.5公里的多伦巴格镇的遇袭前后的卫星图片。图片显示，两个小镇几乎被夷为平地。据悉，两个小镇共有超过3700栋建筑在袭击中被毁。“博科圣地”对尼日利亚北部发起猛烈攻击，巴格镇及周边至少16处定居点被毁，2万名难民逃离家园。</p><p style=\"line-height:150%;letter-spacing: 1px; word-spacing: 2px;text-align:justify;\"><br style=\"text-align:left;\" /></p><p style=\"line-height:150%;letter-spacing: 1px; word-spacing: 2px;text-align:justify;\"></p>";
}
@end
