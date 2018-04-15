//
//  HHFirstVC.m
//  HHSummarize
//
//  Created by LXH on 16/7/26.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "HHFirstVC.h"
#import "HHUILabelVC.h"
#import "HHUIButtonVC.h"
#import "HHUIWebViewVC.h"
#import "HHUITableViewVC.h"
#import "HHConverRectVC.h"
#import "HHUIGestureRecognizerVC.h"

#import <objc/runtime.h>
@interface HHFirstVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HHFirstVC


/**
 1.info.plist文件中添加一项:Fonts provided by application 并添加字体库名字 xxx.ttf
 2.前往TARGETS -> Build Phases -> Copy Bundle Resources中添加字体文件
 3.按照fontName方法遍历找到对应的字体
 4.使用字体 [UIFont fontWithName:@"FZYaSong-M-GBK" size:17];
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"UI界面";
    [self config];
    [self.view addSubview:self.tableView];
    
    //!< 获取手机安装的APP
//    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    
//    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
//    
//    NSArray *apps = [workspace performSelector:@selector(allInstalledApplications)];
//    NSLog(@"appVerson:%@",[apps[0] performSelector:NSSelectorFromString(@"shortVersionString")]);

    Class c =NSClassFromString(@"LSApplicationWorkspace");
    
    id s = [(id)c performSelector:NSSelectorFromString(@"defaultWorkspace")];
    
    NSArray *array = [s performSelector:NSSelectorFromString(@"allInstalledApplications")];
    
    NSDate *date = [NSDate date];
    
    
    
    NSArray *a = @[@"<LSApplicationProxy: 0x13f526870> com.citic.mobile",
                   @"<LSApplicationProxy: 0x13f52f630> com.tencent.",
                   @"<LSApplicationProxy: 0x13f52b840> cn.com.10jqka.IHexin",
                   @"<LSApplicationProxy: 0x13f529c40> com.ubercab.UberClient",
                   @"<LSApplicationProxy: 0x13f52f800> com.apple.mobilenotes",
                   @"<LSApplicationProxy: 0x13f526c10> com.hnmc.newzkqb",
                   @"<LSApplicationProxy: 0x13f52dea0> com.autoradio.MyRadio",
                   @"<LSApplicationProxy: 0x13f526fb0> com.easaa.ZZWBPush",
                   @"<LSApplicationProxy: 0x13f523950> com.apple.iBooks",
                   @"<LSApplicationProxy: 0x13f527e30> net.oschina.iosapp",
                   @"<LSApplicationProxy: 0x13f5252b0> com.apple.mobilemail",
                   @"<LSApplicationProxy: 0x13f533030> com.cunpiao.cunpiao",
                   @"<LSApplicationProxy: 0x13f520fc0> com.apple.CompassCalibrationViewService",
                   @"<LSApplicationProxy: 0x13f51fcd0> com.apple.mobilesms.compose",
                   @"<LSApplicationProxy: 0x13f5278c0> com.zhaoxi",
                   @"<LSApplicationProxy: 0x13f52f9d0> com.webank.wemoney",
                   @"<LSApplicationProxy: 0x13f52fba0> com.meituan.imeituan",
                   @"<LSApplicationProxy: 0x13f5235b0> com.apple.PhotosViewService",
                   @"<LSApplicationProxy: 0x13f52ae60> com.taobao.tmall",
                   @"<LSApplicationProxy: 0x13f52a550> com.chaoui.jiongji100CN",
                   @"<LSApplicationProxy: 0x13f52fd70> www.ityue.com",
                   @"<LSApplicationProxy: 0x13f531c40> com.sumiapp.GridDiary",
                   @"<LSApplicationProxy: 0x13f531a70> com.vipshop.iphone",
                   @"<LSApplicationProxy: 0x13f524260> com.apple.mobiletimer",
                   @"<LSApplicationProxy: 0x13f52eb50> com.cunpiao.cunpiaoshop",
                   @"<LSApplicationProxy: 0x13f52a380> com.shanbay.words",
                   @"<LSApplicationProxy: 0x13f528000> com.wepie.snakegame",
                   @"<LSApplicationProxy: 0x13f520980> com.apple.Diagnostics",
                   @"<LSApplicationProxy: 0x13f527180> com.somytec.thermometer",
                   @"<LSApplicationProxy: 0x13f522da0> com.apple.weather",
                   @"<LSApplicationProxy: 0x13f531e10> com.wdj.eyepetizer",
                   @"<LSApplicationProxy: 0x13f51f3c0> com.apple.SharedWebCredentialViewService",
                   @"<LSApplicationProxy: 0x13f532550> com.wealth.nicaifu",
                   @"<LSApplicationProxy: 0x13f528570> com.baidu.netdisk",
                   @"<LSApplicationProxy: 0x13f52ff40> com.apple.mobileme.fmf1",
                   @"<LSApplicationProxy: 0x13f525650> com.apple.gamecenter.GameCenterUIService",
                   @"<LSApplicationProxy: 0x13f52e5e0> com.apple.MobileReplayer",
                   @"<LSApplicationProxy: 0x13f51f930> com.apple.WebContentFilter.remoteUI.WebContentAnalysisUI",
                   @"<LSApplicationProxy: 0x13f52d760> com.alipay.iphoneclient",
                   @"<LSApplicationProxy: 0x13f531fe0> com.mapboo.itinterview",
                   @"<LSApplicationProxy: 0x13f52e240> com.icetime17.inotes",
                   @"<LSApplicationProxy: 0x13f524b70> com.apple.PassbookUIService",
                   @"<LSApplicationProxy: 0x13f5264d0> com.netease.news",
                   @"<LSApplicationProxy: 0x13f5233e0> com.apple.VoiceMemos",
                   @"<LSApplicationProxy: 0x13f52d3c0> com.antfortune.wealth",
                   @"<LSApplicationProxy: 0x13f527a90> com.taobao.taobao4iphone",
                   @"<LSApplicationProxy: 0x13f51ee50> com.apple.camera",
                   @"<LSApplicationProxy: 0x13f529050> com.easaa.LittleFrog",
                   @"<LSApplicationProxy: 0x13f52d930> com.maxhom.rzdr",
                   @"<LSApplicationProxy: 0x13f532c90> com.howbuy.howbuyfund",
                   @"<LSApplicationProxy: 0x13f527520> com.sns.laopianfang",
                   @"<LSApplicationProxy: 0x13f521e40> com.apple.fieldtest",
                   @"<LSApplicationProxy: 0x13f520410> com.apple.purplebuddy",
                   @"<LSApplicationProxy: 0x13f530110> com.gotokeep.keep",
                   @"<LSApplicationProxy: 0x13f5302e0> com.tencent.weiyun",
                   @"<LSApplicationProxy: 0x13f525bc0> Bison.ITBlog",
                   @"<LSApplicationProxy: 0x13f528910> com.photo2search.remedypro",
                   @"<LSApplicationProxy: 0x13f5249a0> com.apple.datadetectors.DDActionsService",
                   @"<LSApplicationProxy: 0x13f52b4a0> cn.aliqin.KB",
                   @"<LSApplicationProxy: 0x13f5321b0> cn.kuaipan.kuaipanIphone",
                   @"<LSApplicationProxy: 0x13f522010> com.apple.iosdiagnostics",
                   @"<LSApplicationProxy: 0x13f52e980> com.tencent.smoba",
                   @"<LSApplicationProxy: 0x13f51f1f0> com.apple.webapp",
                   @"<LSApplicationProxy: 0x13f51fea0> com.apple.videos",
                   @"<LSApplicationProxy: 0x13f525d90> cn.zaker.iphone",
                   @"<LSApplicationProxy: 0x13f529fe0> com.easaa.zhixunxinwen",
                   @"<LSApplicationProxy: 0x13f5205e0> com.apple.AccountAuthenticationDialog",
                   @"<LSApplicationProxy: 0x13f532380> com.apple.WebViewService",
                   @"<LSApplicationProxy: 0x13f5304b0> com.qunar.iphoneclient8",
                   @"<LSApplicationProxy: 0x13f528ae0> net.csdn.CoderPlus",
                   @"<LSApplicationProxy: 0x13f5247d0> com.apple.CoreAuthUI",
                   @"<LSApplicationProxy: 0x13f522580> com.apple.TrustMe",
                   @"<LSApplicationProxy: 0x13f52a8f0> com.51cto.iPhone",
                   @"<LSApplicationProxy: 0x13f5281d0> com.sogou.sogouinput",
                   @"<LSApplicationProxy: 0x13f528e80> com.ffrj.pinkwallet",
                   @"<LSApplicationProxy: 0x13f531330> com.juzilicai.iphone",
                   @"<LSApplicationProxy: 0x13f530680> cn.dxy.iDxyer",
                   @"<LSApplicationProxy: 0x13f525820> com.apple.PreBoard",
                   @"<LSApplicationProxy: 0x13f5328f0> com.baycode.rbox.cocoachina",
                   @"<LSApplicationProxy: 0x13f532e60> com.tencent.tribe",
                   @"<LSApplicationProxy: 0x13f52aac0> cn.12306.rails12306",
                   @"<LSApplicationProxy: 0x13f528cb0> com.apple.mobileme.fmip1",
                   @"<LSApplicationProxy: 0x13f52cc30> com.doweidu.haoshiqi",
                   @"<LSApplicationProxy: 0x13f52b670> cn.dxy.aspirin",
                   @"<LSApplicationProxy: 0x13f521360> com.apple.mobilecal",
                   @"<LSApplicationProxy: 0x13f52ba10> com.easaa.zhengw",
                   @"<LSApplicationProxy: 0x13f51e630> com.apple.calculator",
                   @"<LSApplicationProxy: 0x13f530850> com.apple.GameController",
                   @"<LSApplicationProxy: 0x13f526300> com.tencent.QQMusic",
                   @"<LSApplicationProxy: 0x13f524430> com.apple.reminders",
                   @"<LSApplicationProxy: 0x13f52f290> cn.thepaper.paper",
                   @"<LSApplicationProxy: 0x13f5266a0> com.tencent.QQKSong",
                   @"<LSApplicationProxy: 0x13f5221e0> com.apple.FacebookAccountMigrationDialog",
                   @"<LSApplicationProxy: 0x13f51bd90> com.apple.ios.StoreKitUIService",
                   @"<LSApplicationProxy: 0x13f526130> com.jianshu.Hugo",
                   @"<LSApplicationProxy: 0x13f527350> com.fanyue.PianFang",
                   @"<LSApplicationProxy: 0x13f521530> com.apple.MobileSMS",
                   @"<LSApplicationProxy: 0x13f51f760> com.apple.MusicUIService",
                   @"<LSApplicationProxy: 0x13f525480> com.apple.stocks",
                   @"<LSApplicationProxy: 0x13f5259f0> com.apple.SiriViewService",
                   @"<LSApplicationProxy: 0x13f52c890> com.dudiangushi.dudiangushi",
                   @"<LSApplicationProxy: 0x13f523ec0> com.apple.share",
                   @"<LSApplicationProxy: 0x13f529a70> com.yidian.design2",
                   @"<LSApplicationProxy: 0x13f52bdb0> com.laiwang.DingTalk",
                   @"<LSApplicationProxy: 0x13f529220> com.apple.DemoApp",
                   @"<LSApplicationProxy: 0x13f52ce00> com.meituan.itakeaway",
                   @"<LSApplicationProxy: 0x13f5276f0> www.coderyi.com.Monkey",
                   @"<LSApplicationProxy: 0x13f530a20> com.pingan.pars",
                   @"<LSApplicationProxy: 0x13f5316d0> tide.moreless.io",
                   @"<LSApplicationProxy: 0x13f533200> com.tencent.QQ-Mobile-Token-2-0",
                   @"<LSApplicationProxy: 0x13f523cf0> com.apple.mobilephone",
                   @"<LSApplicationProxy: 0x13f520df0> com.apple.Maps",
                   @"<LSApplicationProxy: 0x13f521c70> com.apple.compass",
                   @"<LSApplicationProxy: 0x13f524600> com.apple.MobileAddressBook",
                   @"<LSApplicationProxy: 0x13f52a720> com.nowcoder.app.florida",
                   @"<LSApplicationProxy: 0x13f52bf80> com.chinaunicom.mobilebusiness",
                   @"<LSApplicationProxy: 0x13f525f60> com.bankcomm.Bankcomm",
                   @"<LSApplicationProxy: 0x13f530bf0> com.gode.lift",
                   @"<LSApplicationProxy: 0x13f52dcd0> com.51vv.vvim",
                   @"<LSApplicationProxy: 0x13f527c60> com.youdao.note.iphone",
                   @"<LSApplicationProxy: 0x13f523040> com.apple.gamecenter",
                   @"<LSApplicationProxy: 0x13f52ac90> com.baidu.waimai",
                   @"<LSApplicationProxy: 0x13f5207b0> com.apple.AdSheetPhone",
                   @"<LSApplicationProxy: 0x13f52f0c0> com.netease.cloudmusic",
                   @"<LSApplicationProxy: 0x13f52a1b0> com.luojilab.LuoJiFM-IOS",
                   @"<LSApplicationProxy: 0x13f521700> com.apple.uikit.PrintStatus",
                   @"<LSApplicationProxy: 0x13f5318a0> com.changba.ktv",
                   @"<LSApplicationProxy: 0x13f532ac0> com.brandy.zyzlbj",
                   @"<LSApplicationProxy: 0x13f5333d0> com.pingan.pacaifubao",
                   @"<LSApplicationProxy: 0x13f521aa0> com.apple.podcasts",
                   @"<LSApplicationProxy: 0x13f523210> com.apple.appleaccount.AACredentialRecoveryDialog",
                   @"<LSApplicationProxy: 0x13f51d3c0> com.apple.MobileStore",
                   @"<LSApplicationProxy: 0x13f529e10> com.sinolending.SLMobile",
                   @"<LSApplicationProxy: 0x13f521190> com.apple.PrintKit.Print-Center",
                   @"<LSApplicationProxy: 0x13f523b20> com.apple.Preferences",
                   @"<LSApplicationProxy: 0x13f5293f0> cn.10086.zsyyt",
                   @"<LSApplicationProxy: 0x13f520240> com.apple.Health",
                   @"<LSApplicationProxy: 0x13f51fb00> com.apple.mobilesms.notification",
                   @"<LSApplicationProxy: 0x13f526a40> com.jianke.jiankemall",
                   @"<LSApplicationProxy: 0x13f52c150> com.tencent.xin",
                   @"<LSApplicationProxy: 0x13f52e070> com.sina.weibo",
                   @"<LSApplicationProxy: 0x13f5283a0> com.zhiyun168.feel",
                   @"<LSApplicationProxy: 0x13f5250e0> com.apple.WebSheet",
                   @"<LSApplicationProxy: 0x13f51f020> com.apple.quicklook.quicklookd",
                   @"<LSApplicationProxy: 0x13f5296d0> com.tencent.QQPim",
                   @"<LSApplicationProxy: 0x13f530dc0> com.apple.MailCompositionService",
                   @"<LSApplicationProxy: 0x13f522a00> com.apple.AppStore",
                   @"<LSApplicationProxy: 0x13f531160> com.360buy.jdmobile",
                   @"<LSApplicationProxy: 0x13f5298a0> com.apple.Passbook",
                   @"<LSApplicationProxy: 0x13f52f460> com.hhlm.HHSummarize",
                   @"<LSApplicationProxy: 0x13f524f10> com.apple.InCallService",
                   @"<LSApplicationProxy: 0x13f52c320> com.ccb.ccbDemo",
                   @"<LSApplicationProxy: 0x13f522750> com.apple.family",
                   @"<LSApplicationProxy: 0x13f52b200> com.fengwo.reading",
                   @"<LSApplicationProxy: 0x13f52c4f0> com.2345.KingWeather",
                   @"<LSApplicationProxy: 0x13f50ff00> com.apple.tips",
                   @"<LSApplicationProxy: 0x13f522bd0> com.apple.mobilesafari",
                   @"<LSApplicationProxy: 0x13f52e7b0> com.easaa.FitMent",
                   @"<LSApplicationProxy: 0x13f52c6c0> com.xiaojukeji.didi",
                   @"<LSApplicationProxy: 0x13f520070> com.apple.mobileslideshow",
                   @"<LSApplicationProxy: 0x13f524090> com.apple.TencentWeiboAccountMigrationDialog",
                   @"<LSApplicationProxy: 0x13f523780> com.apple.facetime",
                   @"<LSApplicationProxy: 0x13f528740> com.taobao.fleamarket",
                   @"<LSApplicationProxy: 0x13f52ca60> com.ron.blvpn",
                   @"<LSApplicationProxy: 0x13f52b030> com.zubunet.app.scienceba",
                   @"<LSApplicationProxy: 0x13f532720> com.flipboard.flipboard-ipad-zh",
                   @"<LSApplicationProxy: 0x13f520b50> com.apple.AskPermissionUI",
                   @"<LSApplicationProxy: 0x13f52d590> com.cunpiao.midas",
                   @"<LSApplicationProxy: 0x13f52eef0> com.codoon.gps",
                   @"<LSApplicationProxy: 0x13f52db00> com.leichunfeng.MVVMReactiveCocoa",
                   @"<LSApplicationProxy: 0x13f51f590> com.apple.iad.iAdOptOut",
                   @"<LSApplicationProxy: 0x13f530f90> com.mukewang.mukewang",
                   @"<LSApplicationProxy: 0x13f52bbe0> com.tencent.mqq",
                   @"<LSApplicationProxy: 0x13f526de0> com.Ming-Zhe.circle-ios",
                   @"<LSApplicationProxy: 0x13f5218d0> com.apple.Music",
                   @"<LSApplicationProxy: 0x13f52e410> com.gemd.iting",
                   @"<LSApplicationProxy: 0x13f524d40> com.apple.webapp1",
                   @"<LSApplicationProxy: 0x13f52ed20> io.manong.DeveloperDaily",
                   @"<LSApplicationProxy: 0x13f5223b0> com.apple.HealthPrivacyService",
                   @"<LSApplicationProxy: 0x13f531500> cn.com.people.peopledailyphone"];
    
    NSArray *a1 = @[@"<LSApplicationProxy: 0x156531d30> com.tencent.",
                    @"<LSApplicationProxy: 0x156620510> cn.com.10jqka.IHexin",
                    @"<LSApplicationProxy: 0x15661e910> com.ubercab.UberClient",
                    @"<LSApplicationProxy: 0x156531f00> com.apple.mobilenotes",
                    @"<LSApplicationProxy: 0x15652b930> com.hnmc.newzkqb",
                    @"<LSApplicationProxy: 0x156530770> com.autoradio.MyRadio",
                    @"<LSApplicationProxy: 0x15652bcd0> com.easaa.ZZWBPush",
                    @"<LSApplicationProxy: 0x156528670> com.apple.iBooks",
                    @"<LSApplicationProxy: 0x15652cb50> net.oschina.iosapp",
                    @"<LSApplicationProxy: 0x156529fd0> com.apple.mobilemail",
                    @"<LSApplicationProxy: 0x156535730> com.cunpiao.cunpiao",
                    @"<LSApplicationProxy: 0x156525ce0> com.apple.CompassCalibrationViewService",
                    @"<LSApplicationProxy: 0x1565249f0> com.apple.mobilesms.compose",
                    @"<LSApplicationProxy: 0x15652c5e0> com.zhaoxi",
                    @"<LSApplicationProxy: 0x1565320d0> com.webank.wemoney",
                    @"<LSApplicationProxy: 0x1565322a0> com.meituan.imeituan",
                    @"<LSApplicationProxy: 0x1565282d0> com.apple.PhotosViewService",
                    @"<LSApplicationProxy: 0x15661fb30> com.taobao.tmall",
                    @"<LSApplicationProxy: 0x15661f220> com.chaoui.jiongji100CN",
                    @"<LSApplicationProxy: 0x156532470> www.ityue.com",
                    @"<LSApplicationProxy: 0x156534340> com.sumiapp.GridDiary",
                    @"<LSApplicationProxy: 0x156534170> com.vipshop.iphone",
                    @"<LSApplicationProxy: 0x156528f80> com.apple.mobiletimer",
                    @"<LSApplicationProxy: 0x156531420> com.cunpiao.cunpiaoshop",
                    @"<LSApplicationProxy: 0x15661f050> com.shanbay.words",
                    @"<LSApplicationProxy: 0x15652cd20> com.wepie.snakegame",
                    @"<LSApplicationProxy: 0x1565256a0> com.apple.Diagnostics",
                    @"<LSApplicationProxy: 0x15652bea0> com.somytec.thermometer",
                    @"<LSApplicationProxy: 0x156527ac0> com.apple.weather",
                    @"<LSApplicationProxy: 0x156534510> com.wdj.eyepetizer",
                    @"<LSApplicationProxy: 0x1565240e0> com.apple.SharedWebCredentialViewService",
                    @"<LSApplicationProxy: 0x156534c50> com.wealth.nicaifu",
                    @"<LSApplicationProxy: 0x15652d290> com.baidu.netdisk",
                    @"<LSApplicationProxy: 0x156532640> com.apple.mobileme.fmf1",
                    @"<LSApplicationProxy: 0x15652a370> com.apple.gamecenter.GameCenterUIService",
                    @"<LSApplicationProxy: 0x156530eb0> com.apple.MobileReplayer",
                    @"<LSApplicationProxy: 0x156524650> com.apple.WebContentFilter.remoteUI.WebContentAnalysisUI",
                    @"<LSApplicationProxy: 0x156530030> com.alipay.iphoneclient",
                    @"<LSApplicationProxy: 0x1565346e0> com.mapboo.itinterview",
                    @"<LSApplicationProxy: 0x156530b10> com.icetime17.inotes",
                    @"<LSApplicationProxy: 0x156529890> com.apple.PassbookUIService",
                    @"<LSApplicationProxy: 0x15652b1f0> com.netease.news",
                    @"<LSApplicationProxy: 0x156528100> com.apple.VoiceMemos",
                    @"<LSApplicationProxy: 0x15652fc90> com.antfortune.wealth",
                    @"<LSApplicationProxy: 0x15652c7b0> com.taobao.taobao4iphone",
                    @"<LSApplicationProxy: 0x156523b70> com.apple.camera",
                    @"<LSApplicationProxy: 0x156530200> com.maxhom.rzdr",
                    @"<LSApplicationProxy: 0x156535390> com.howbuy.howbuyfund",
                    @"<LSApplicationProxy: 0x15652c240> com.sns.laopianfang",
                    @"<LSApplicationProxy: 0x156526b60> com.apple.fieldtest",
                    @"<LSApplicationProxy: 0x156525130> com.apple.purplebuddy",
                    @"<LSApplicationProxy: 0x156532810> com.gotokeep.keep",
                    @"<LSApplicationProxy: 0x1565329e0> com.tencent.weiyun",
                    @"<LSApplicationProxy: 0x15652a8e0> Bison.ITBlog",
                    @"<LSApplicationProxy: 0x15652d630> com.photo2search.remedypro",
                    @"<LSApplicationProxy: 0x1565296c0> com.apple.datadetectors.DDActionsService",
                    @"<LSApplicationProxy: 0x156620170> cn.aliqin.KB",
                    @"<LSApplicationProxy: 0x1565348b0> cn.kuaipan.kuaipanIphone",
                    @"<LSApplicationProxy: 0x156526d30> com.apple.iosdiagnostics",
                    @"<LSApplicationProxy: 0x156531250> com.tencent.smoba",
                    @"<LSApplicationProxy: 0x156523f10> com.apple.webapp",
                    @"<LSApplicationProxy: 0x156524bc0> com.apple.videos",
                    @"<LSApplicationProxy: 0x15652aab0> cn.zaker.iphone",
                    @"<LSApplicationProxy: 0x15661ecb0> com.easaa.zhixunxinwen",
                    @"<LSApplicationProxy: 0x156525300> com.apple.AccountAuthenticationDialog",
                    @"<LSApplicationProxy: 0x156534a80> com.apple.WebViewService",
                    @"<LSApplicationProxy: 0x156532bb0> com.qunar.iphoneclient8",
                    @"<LSApplicationProxy: 0x15652d800> net.csdn.CoderPlus",
                    @"<LSApplicationProxy: 0x1565294f0> com.apple.CoreAuthUI",
                    @"<LSApplicationProxy: 0x1565272a0> com.apple.TrustMe",
                    @"<LSApplicationProxy: 0x15661f5c0> com.51cto.iPhone",
                    @"<LSApplicationProxy: 0x15652cef0> com.sogou.sogouinput",
                    @"<LSApplicationProxy: 0x15652dba0> com.ffrj.pinkwallet",
                    @"<LSApplicationProxy: 0x156533a30> com.juzilicai.iphone",
                    @"<LSApplicationProxy: 0x156532d80> cn.dxy.iDxyer",
                    @"<LSApplicationProxy: 0x15652a540> com.apple.PreBoard",
                    @"<LSApplicationProxy: 0x156534ff0> com.baycode.rbox.cocoachina",
                    @"<LSApplicationProxy: 0x156535560> com.tencent.tribe",
                    @"<LSApplicationProxy: 0x15661f790> cn.12306.rails12306",
                    @"<LSApplicationProxy: 0x15652d9d0> com.apple.mobileme.fmip1",
                    @"<LSApplicationProxy: 0x15652f500> com.doweidu.haoshiqi",
                    @"<LSApplicationProxy: 0x156620340> cn.dxy.aspirin",
                    @"<LSApplicationProxy: 0x156526080> com.apple.mobilecal",
                    @"<LSApplicationProxy: 0x1566206e0> com.easaa.zhengw",
                    @"<LSApplicationProxy: 0x15651eaa0> com.apple.calculator",
                    @"<LSApplicationProxy: 0x156532f50> com.apple.GameController",
                    @"<LSApplicationProxy: 0x15652b020> com.tencent.QQMusic",
                    @"<LSApplicationProxy: 0x156529150> com.apple.reminders",
                    @"<LSApplicationProxy: 0x156531b60> cn.thepaper.paper",
                    @"<LSApplicationProxy: 0x15652b3c0> com.tencent.QQKSong",
                    @"<LSApplicationProxy: 0x156526f00> com.apple.FacebookAccountMigrationDialog",
                    @"<LSApplicationProxy: 0x156523600> com.apple.ios.StoreKitUIService",
                    @"<LSApplicationProxy: 0x15652ae50> com.jianshu.Hugo",
                    @"<LSApplicationProxy: 0x15652c070> com.fanyue.PianFang",
                    @"<LSApplicationProxy: 0x156526250> com.apple.MobileSMS",
                    @"<LSApplicationProxy: 0x156524480> com.apple.MusicUIService",
                    @"<LSApplicationProxy: 0x15652a1a0> com.apple.stocks",
                    @"<LSApplicationProxy: 0x15652a710> com.apple.SiriViewService",
                    @"<LSApplicationProxy: 0x15652f160> com.dudiangushi.dudiangushi",
                    @"<LSApplicationProxy: 0x156528be0> com.apple.share",
                    @"<LSApplicationProxy: 0x15652e680> com.yidian.design2",
                    @"<LSApplicationProxy: 0x156620a80> com.laiwang.DingTalk",
                    @"<LSApplicationProxy: 0x15652df40> com.apple.DemoApp",
                    @"<LSApplicationProxy: 0x156533120> com.pingan.pars",
                    @"<LSApplicationProxy: 0x15652c410> www.coderyi.com.Monkey",
                    @"<LSApplicationProxy: 0x15652f6d0> com.meituan.itakeaway",
                    @"<LSApplicationProxy: 0x156533dd0> tide.moreless.io",
                    @"<LSApplicationProxy: 0x156535900> com.tencent.QQ-Mobile-Token-2-0",
                    @"<LSApplicationProxy: 0x156528a10> com.apple.mobilephone",
                    @"<LSApplicationProxy: 0x156525b10> com.apple.Maps",
                    @"<LSApplicationProxy: 0x156526990> com.apple.compass",
                    @"<LSApplicationProxy: 0x156529320> com.apple.MobileAddressBook",
                    @"<LSApplicationProxy: 0x15661f3f0> com.nowcoder.app.florida",
                    @"<LSApplicationProxy: 0x15652e850> com.chinaunicom.mobilebusiness",
                    @"<LSApplicationProxy: 0x15652ac80> com.bankcomm.Bankcomm",
                    @"<LSApplicationProxy: 0x1565332f0> com.gode.lift",
                    @"<LSApplicationProxy: 0x1565305a0> com.51vv.vvim",
                    @"<LSApplicationProxy: 0x15652c980> com.youdao.note.iphone",
                    @"<LSApplicationProxy: 0x156527d60> com.apple.gamecenter",
                    @"<LSApplicationProxy: 0x15661f960> com.baidu.waimai",
                    @"<LSApplicationProxy: 0x1565254d0> com.apple.AdSheetPhone",
                    @"<LSApplicationProxy: 0x156531990> com.netease.cloudmusic",
                    @"<LSApplicationProxy: 0x15661ee80> com.luojilab.LuoJiFM-IOS",
                    @"<LSApplicationProxy: 0x156526420> com.apple.uikit.PrintStatus",
                    @"<LSApplicationProxy: 0x156533fa0> com.changba.ktv",
                    @"<LSApplicationProxy: 0x1565351c0> com.brandy.zyzlbj",
                    @"<LSApplicationProxy: 0x156535ad0> com.pingan.pacaifubao",
                    @"<LSApplicationProxy: 0x1565267c0> com.apple.podcasts",
                    @"<LSApplicationProxy: 0x156527f30> com.apple.appleaccount.AACredentialRecoveryDialog",
                    @"<LSApplicationProxy: 0x1565237d0> com.apple.MobileStore",
                    @"<LSApplicationProxy: 0x15661eae0> com.sinolending.SLMobile",
                    @"<LSApplicationProxy: 0x156525eb0> com.apple.PrintKit.Print-Center",
                    @"<LSApplicationProxy: 0x156528840> com.apple.Preferences",
                    @"<LSApplicationProxy: 0x15652e110> cn.10086.zsyyt",
                    @"<LSApplicationProxy: 0x156524f60> com.apple.Health",
                    @"<LSApplicationProxy: 0x156524820> com.apple.mobilesms.notification",
                    @"<LSApplicationProxy: 0x15652b760> com.jianke.jiankemall",
                    @"<LSApplicationProxy: 0x15652ea20> com.tencent.xin",
                    @"<LSApplicationProxy: 0x156530940> com.sina.weibo",
                    @"<LSApplicationProxy: 0x15652d0c0> com.zhiyun168.feel",
                    @"<LSApplicationProxy: 0x156529e00> com.apple.WebSheet",
                    @"<LSApplicationProxy: 0x156523d40> com.apple.quicklook.quicklookd",
                    @"<LSApplicationProxy: 0x15652e2e0> com.tencent.QQPim",
                    @"<LSApplicationProxy: 0x1565334c0> com.apple.MailCompositionService",
                    @"<LSApplicationProxy: 0x156527720> com.apple.AppStore",
                    @"<LSApplicationProxy: 0x156533860> com.360buy.jdmobile",
                    @"<LSApplicationProxy: 0x15652e4b0> com.apple.Passbook",
                    @"<LSApplicationProxy: 0x15652dd70> com.hhlm.HHSummarize",
                    @"<LSApplicationProxy: 0x156529c30> com.apple.InCallService",
                    @"<LSApplicationProxy: 0x15652ebf0> com.ccb.ccbDemo",
                    @"<LSApplicationProxy: 0x156527470> com.apple.family",
                    @"<LSApplicationProxy: 0x15661fed0> com.fengwo.reading",
                    @"<LSApplicationProxy: 0x15652edc0> com.2345.KingWeather",
                    @"<LSApplicationProxy: 0x1565239a0> com.apple.tips",
                    @"<LSApplicationProxy: 0x1565278f0> com.apple.mobilesafari",
                    @"<LSApplicationProxy: 0x156531080> com.easaa.FitMent",
                    @"<LSApplicationProxy: 0x15652ef90> com.xiaojukeji.didi",
                    @"<LSApplicationProxy: 0x156524d90> com.apple.mobileslideshow",
                    @"<LSApplicationProxy: 0x156528db0> com.apple.TencentWeiboAccountMigrationDialog",
                    @"<LSApplicationProxy: 0x1565284a0> com.apple.facetime",
                    @"<LSApplicationProxy: 0x15652d460> com.taobao.fleamarket",
                    @"<LSApplicationProxy: 0x15652f330> com.ron.blvpn",
                    @"<LSApplicationProxy: 0x15661fd00> com.zubunet.app.scienceba",
                    @"<LSApplicationProxy: 0x156534e20> com.flipboard.flipboard-ipad-zh",
                    @"<LSApplicationProxy: 0x156525870> com.apple.AskPermissionUI",
                    @"<LSApplicationProxy: 0x15652fe60> com.cunpiao.midas",
                    @"<LSApplicationProxy: 0x1565317c0> com.codoon.gps",
                    @"<LSApplicationProxy: 0x1565303d0> com.leichunfeng.MVVMReactiveCocoa",
                    @"<LSApplicationProxy: 0x1565242b0> com.apple.iad.iAdOptOut",
                    @"<LSApplicationProxy: 0x156533690> com.mukewang.mukewang",
                    @"<LSApplicationProxy: 0x1566208b0> com.tencent.mqq",
                    @"<LSApplicationProxy: 0x15652bb00> com.Ming-Zhe.circle-ios",
                    @"<LSApplicationProxy: 0x1565265f0> com.apple.Music",
                    @"<LSApplicationProxy: 0x156530ce0> com.gemd.iting",
                    @"<LSApplicationProxy: 0x156529a60> com.apple.webapp1",
                    @"<LSApplicationProxy: 0x1565315f0> io.manong.DeveloperDaily",
                    @"<LSApplicationProxy: 0x1565270d0> com.apple.HealthPrivacyService",
                    @"<LSApplicationProxy: 0x156533c00> cn.com.people.peopledailyphone"];
    
    NSMutableArray *arrB = [NSMutableArray array];
    [arrB setArray:a];
    [arrB removeObjectsInArray:a1];//后面接的是一个不可变数组
    
    NSLog(@"移除相同元素后的数组--%@---%d--%d",arrB,a.count,a1.count);
    //    for (id item in array) {
    //        
    //        NSLog(@"%@",[item performSelector:NSSelectorFromString(@"applicationIdentifier")]);
    //        
    //        NSLog(@"%@",[item performSelector:NSSelectorFromString(@"bundleIdentifier")]);
//        
//        NSLog(@"%@",[item performSelector:NSSelectorFromString(@"bundleVersion")]);
//        
//        NSLog(@"%@",[item performSelector:NSSelectorFromString(@"shortVersionString")]);
//        
//
//    }
}
- (void)defaultWorkspace
{
    
}
- (void)config
{
    self.dataArray = @[@"UILabel",@"UIButton",@"UIImageView",@"UIFont",@"UIWebView",@"UITableView",@"UICollection",@"ConverRect",@"UIGestureRecognizer",@"ScrollView"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = [self.dataArray objectAtIndex:indexPath.row];
    name = [@"HH" stringByAppendingString:name];
    name = [name stringByAppendingString:@"VC"];
    Class class = NSClassFromString(name);
    HHBaseVC *vc = [[class alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView =[[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
