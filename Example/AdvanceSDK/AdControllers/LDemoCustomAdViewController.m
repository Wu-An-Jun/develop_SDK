//
//  DemoInterstitialViewController.m
//  advancelib
//
//  Created by allen on 2019/12/31.
//  Copyright © 2019 Bayescom. All rights reserved.
//

#import "LDemoCustomAdViewController.h"
#import "AdvanceInterstitial.h" // 导入插屏广告头文件
#import <newios_sdk/AdvanceRewardVideo.h> // 导入激励视频广告头文件
#import "AdvanceBanner.h" // 导入Banner广告头文件
#import "AdvanceFullScreenVideo.h" // 导入全屏广告头文件
#import <newios_sdk/AdvanceSplash.h> // 导入开屏广告头文件
#import "DemoFeedExpressViewController.h" // 信息流广告Demo入口页面（广告位选择、入口按钮等）
#import "DemoListFeedExpressViewController.h" // 信息流广告列表页面（实际加载和展示广告内容）


@interface LDemoCustomAdViewController () <AdvanceInterstitialDelegate, AdvanceRewardedVideoDelegate, AdvanceBannerDelegate, AdvanceFullScreenVideoDelegate, AdvanceSplashDelegate> // 遵守广告代理协议
@property (nonatomic, strong) AdvanceInterstitial *advanceInterstitial; // 声明插屏广告对象
@property (nonatomic, strong) AdvanceRewardVideo *advanceRewardVideo; // 声明激励视频广告对象
@property (nonatomic, strong) AdvanceBanner *advanceBanner; // 声明Banner广告对象
@property (nonatomic, strong) UIView *bannerContainer; // Banner广告容器

@property (nonatomic, strong) AdvanceFullScreenVideo *advanceFullScreenVideo; // 声明全屏广告对象
@property (nonatomic) bool isAdLoaded; // 看是否缓存完毕

@property(strong,nonatomic) AdvanceSplash *advanceSplash; // 声明开屏广告对象
@property (nonatomic, strong) UIImageView *bgImgV;  // 图片
@end

@implementation LDemoCustomAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广告Demo集合";
    self.btn1Title = @"加载并展示（插屏广告）";
    self.btn2Title = @"加载并展示（激励广告）";
    // 新增全屏广告按钮、loadFullScreenAd
    UIButton *btnFull = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnFull setTitle:@"加载并展示（全屏广告）" forState:UIControlStateNormal];
    btnFull.titleLabel.font = [UIFont systemFontOfSize:16];
    btnFull.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    btnFull.layer.cornerRadius = 8;
    btnFull.frame = CGRectMake(10, CGRectGetMaxY(self.view.subviews.lastObject.frame)+16, self.view.bounds.size.width-20, 50);
    [btnFull addTarget:self action:@selector(loadFullScreenAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFull];
    
    // 新增开屏广告按钮、loadSplashAction
    UIButton *SplashFull = [UIButton buttonWithType:UIButtonTypeSystem];
    [SplashFull setTitle:@"加载并展示（开屏广告）" forState:UIControlStateNormal];
    SplashFull.titleLabel.font = [UIFont systemFontOfSize:16];
    SplashFull.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    SplashFull.layer.cornerRadius = 8;
    SplashFull.frame = CGRectMake(10, CGRectGetMaxY(self.view.subviews.lastObject.frame)+16, self.view.bounds.size.width-20, 50);
    [SplashFull addTarget:self action:@selector(loadSplashAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SplashFull];
    
    // 新增信息流广告按钮, loadFeedExpressAction
    UIButton *btnFeedExpress = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnFeedExpress setTitle:@"加载并展示（信息流广告）" forState:UIControlStateNormal];
    btnFeedExpress.titleLabel.font = [UIFont systemFontOfSize:16];
    btnFeedExpress.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    btnFeedExpress.layer.cornerRadius = 8;
    btnFeedExpress.frame = CGRectMake(10, CGRectGetMaxY(self.view.subviews.lastObject.frame)+16, self.view.bounds.size.width-20, 50);
    [btnFeedExpress addTarget:self action:@selector(loadFeedExpressAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFeedExpress];

    
    
    // 新增Banner广告按钮
    UIButton *btnBanner = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnBanner setTitle:@"加载并展示（Banner广告）" forState:UIControlStateNormal];
    btnBanner.titleLabel.font = [UIFont systemFontOfSize:16];
    btnBanner.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    btnBanner.layer.cornerRadius = 8;
    btnBanner.frame = CGRectMake(10, CGRectGetMaxY(self.view.subviews.lastObject.frame)+16, self.view.bounds.size.width-20, 50);
    [btnBanner addTarget:self action:@selector(loadBannerAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBanner];
    // Banner广告容器
    CGFloat midY = (self.view.bounds.size.height - 100) / 2.0;
    self.bannerContainer = [[UIView alloc] initWithFrame:CGRectMake(0, midY, self.view.bounds.size.width, 100)];
    [self.view addSubview:self.bannerContainer];
    
    
}

// 重写"加载广告"按钮事件
- (void)loadAdBtn1Action {
    NSLog(@"点击了加载广告按钮");
    
    // 1. 初始化插屏广告对象
//    self.advanceInterstitial = [[AdvanceInterstitial alloc] initWithAdspotId:@"10000034"
//                                                                  customExt:nil
//                                                             viewController:self];
    self.advanceInterstitial = [[AdvanceInterstitial alloc] initWithAdspotId:@"10007791"
                                                                  customExt:nil
                                                             viewController:self];
    
    // 2. 设置广告代理
    self.advanceInterstitial.delegate = self;
    // 2. 这种是不可以的，这种是临时变量
//    LDemoCustomAdViewController *InterstVC = [[LDemoCustomAdViewController alloc] init];
//    self.advanceInterstitial.delegate = InterstVC;
    
    // 3. 加载广告
    [self.advanceInterstitial loadAd];
}

// 新增激励视频广告加载事件
- (void)loadAdBtn2Action {
    NSLog(@"点击了加载激励视频广告按钮");
    // 检查当前是否有有效广告
    if (self.advanceRewardVideo.isAdValid) {
        // 有效广告直接展示
        [self.advanceRewardVideo showAd];
        return;
    }
    // 无有效广告时才重新创建并加载
    self.advanceRewardVideo = [[AdvanceRewardVideo alloc] initWithAdspotId:@"10008526"
                                                                 customExt:nil
                                                            viewController:self];
    self.advanceRewardVideo.delegate = self;
    [self.advanceRewardVideo loadAd];
}
// 新增信息流广告加载事件
- (void)loadFeedExpressAction {
    DemoListFeedExpressViewController *vc = [[DemoListFeedExpressViewController alloc] init];
    vc.count = 1;
    vc.mediaId = @"102768";
    vc.adspotId = @"10007789";
    vc.ext = self.ext;
    [self.navigationController pushViewController:vc animated:YES];
}

// 新增Banner广告加载事件
- (void)loadBannerAd {
    NSLog(@"点击了加载Banner广告按钮");
    [self.bannerContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    self.advanceBanner = [[AdvanceBanner alloc] initWithAdspotId:@"10000033" adContainer:self.bannerContainer customExt:nil viewController:self];
    self.advanceBanner = [[AdvanceBanner alloc] initWithAdspotId:@"10007790" adContainer:self.bannerContainer customExt:nil viewController:self];

    self.advanceBanner.delegate = self;
    self.advanceBanner.refreshInterval = 30;
    [self.advanceBanner loadAd];
}

- (void)loadFullScreenAd {
    NSLog(@"点击了加载Full广告按钮");
   
    self.advanceFullScreenVideo = [[AdvanceFullScreenVideo alloc] initWithAdspotId:@"10007830" customExt:nil viewController:self];
    self.advanceFullScreenVideo.delegate = self;
    [self.advanceFullScreenVideo loadAd];
    
}

- (void)loadSplashAction {
    [self.view.window addSubview:self.bgImgV];
    if (self.advanceSplash) {
        self.advanceSplash.delegate = nil;
        self.advanceSplash = nil;
    }
    
    // 每次加载广告请 使用新的实例  不要用懒加载, 不要对广告对象进行本地化存储相关的操作
    self.advanceSplash = [[AdvanceSplash alloc] initWithAdspotId:@"10007798"
                                                       customExt:@{@"testExt": @1} viewController:self];

    self.advanceSplash.delegate = self;
    
    
    /**
      logo图片不应该仅是一张透明的logo 应该是一张有背景的logo, 且高度等于你设置的logo高度
     
      self.advanceSplash.logoImage = [UIImage imageNamed:@"app_logo"];

     */
    
    // 如果想要对logo有特定的布局 则参照 -createLogoImageFromView 方法
    // 建议设置logo 避免某些素材长图不足时屏幕下方留白
    self.advanceSplash.logoImage = [self createLogoImageFromView];
    // 设置logo时 该属性要设置为YES
    self.advanceSplash.showLogoRequire = NO;

    // 如果该时间内没有广告返回 即:未触发-advanceUnifiedViewDidLoad 回调, 则会结束本次广告加载,并触发错误回调
    //self.advanceSplash.timeout = 5;//<---- 确保timeout 时长内不对advanceSplash进行移除的操作
    [self.advanceSplash loadAd];
    //NSLog(@"是否有广告返回 : %d", self.advanceSplash.isLoadAdSucceed);

}


- (UIImage*)createLogoImageFromView

{
    // 在这个方法里你可以随意 定制化logo
   // 300 170
    CGFloat width = self.view.frame.size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 120)];
    view.backgroundColor = [UIColor blueColor];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_logo"]];
    [view addSubview:imageV];
    imageV.frame = CGRectMake(0, 0, 100 * (300/170.f), 100);
    imageV.center = view.center;
    
//obtain scale
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width,
                                                      120), NO,scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //开始生成图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)showAd {
    [self.advanceSplash showInWindow:self.view.window];
}

// MARK: ======================= AdvanceInterstitialDelegate =======================

/// 广告策略加载成功
- (void)didFinishLoadingADPolicyWithSpotId:(NSString *)spotId {
    NSLog(@"%s 广告位id为: %@",__func__ , spotId);
}

/// 广告策略或者渠道广告加载失败
- (void)didFailLoadingADSourceWithSpotId:(NSString *)spotId error:(NSError *)error description:(NSDictionary *)description {
    [JDStatusBarNotification showWithStatus:@"广告加载失败" dismissAfter:1.5];
    NSLog(@"广告展示失败 %s  error: %@ 详情:%@", __func__, error, description);
}

/// 广告位中某一个广告源开始加载广告
- (void)didStartLoadingADSourceWithSpotId:(NSString *)spotId sourceId:(NSString *)sourceId {
    NSLog(@"广告位中某一个广告源开始加载广告 %s  sourceId: %@", __func__, sourceId);
}

/// 插屏广告数据拉取成功展示广告
- (void)didFinishLoadingInterstitialADWithSpotId:(NSString *)spotId {
    NSLog(@"广告数据拉取成功 %s", __func__);
    [JDStatusBarNotification showWithStatus:@"广告加载成功" dismissAfter:1.5];
    [self.advanceInterstitial showAd];
}

/// 广告曝光
- (void)interstitialDidShowForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告曝光回调 %s", __func__);
}

/// 广告点击
- (void)interstitialDidClickForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告点击 %s", __func__);
}

/// 广告关闭
- (void)interstitialDidCloseForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    self.advanceInterstitial = nil;
    NSLog(@"广告关闭了 %s", __func__);
}

// ======================= AdvanceRewardedVideoDelegate =======================
- (void)didFinishLoadingRewardVideoADWithSpotId:(NSString *)spotId {
    NSLog(@"激励视频广告加载成功");
    [JDStatusBarNotification showWithStatus:@"激励视频广告加载成功" dismissAfter:1.5];
    [self.advanceRewardVideo showAd];
}
- (void)rewardVideoDidCloseForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    self.advanceRewardVideo = nil;
    NSLog(@"激励视频广告关闭");
}

- (void)rewardedVideoDidDownLoadForSpotId:(NSString *)spotId extra:(NSDictionary *)extra{
    NSLog(@"激励视频广告缓存成功");
    [JDStatusBarNotification showWithStatus:@"视频广告缓存成功" dismissAfter:1.5];
    [self.advanceRewardVideo showAd];
}

// ======================= AdvanceBannerDelegate =======================
- (void)didFinishLoadingBannerADWithSpotId:(NSString *)spotId {
    NSLog(@"Banner广告加载成功");
    [self.advanceBanner showAd];
//    [self.adShowView addSubview:self.contentV];
}
- (void)bannerView:(UIView *)bannerView didCloseAdWithSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"Banner广告关闭");
    [bannerView removeFromSuperview];
}

- (void)dealloc {
    NSLog(@"%s",__func__);

}

// MARK: ======================= AdvanceFullScreenVideoDelegate =======================
/// 全屏视频广告数据拉取成功
- (void)didFinishLoadingFullscreenVideoADWithSpotId:(NSString *)spotId {
    NSLog(@"广告数据拉取成功, 正在缓存... %s", __func__);
    [JDStatusBarNotification showWithStatus:@"广告加载成功" dismissAfter:1.5];
}

/// 全屏视频缓存成功
- (void)fullscreenVideoDidDownLoadForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告缓存成功 %s", __func__);
    [JDStatusBarNotification showWithStatus:@"视频缓存成功" dismissAfter:1.5];
    [JDStatusBarNotification showWithStatus:@"视频正在展示" dismissAfter:1.5];
    if (self.advanceFullScreenVideo.isAdValid) {
        [self.advanceFullScreenVideo showAd];
    }
}


// MARK: ======================= AdvanceSplashDelegate =======================
/// 开屏广告数据拉取成功
- (void)didFinishLoadingSplashADWithSpotId:(NSString *)spotId {
    NSLog(@"广告数据拉取成功 %s", __func__);
    [self showAd];
}

/// 广告曝光成功
- (void)splashDidShowForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告曝光成功 %s", __func__);
    // 移除背景图
    [self removeBgImgView];
}
- (void)removeBgImgView {
    [self.bgImgV removeFromSuperview];
    self.bgImgV = nil;
}

//- (UIImageView *)bgImgV {
//    if (!_bgImgV) {
//        _bgImgV = [[UIImageView alloc] init];
//        _bgImgV.frame = [UIScreen mainScreen].bounds;
//        _bgImgV.image = [UIImage imageNamed:@"LaunchImage_img"];
//    }
//    return _bgImgV;
//}
@end
