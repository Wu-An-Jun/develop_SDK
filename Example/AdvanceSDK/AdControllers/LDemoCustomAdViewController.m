//
//  DemoInterstitialViewController.m
//  advancelib
//
//  Created by allen on 2019/12/31.
//  Copyright © 2019 Bayescom. All rights reserved.
//

#import "LDemoCustomAdViewController.h"
#import "AdvanceInterstitial.h" // 导入插屏广告头文件

@interface LDemoCustomAdViewController () <AdvanceInterstitialDelegate> // 遵守广告代理协议
@property (nonatomic, strong) AdvanceInterstitial *advanceInterstitial; // 声明广告对象
@end

@implementation LDemoCustomAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广告Demo集合";
    self.btn1Title = @"加载并展示（插屏广告）";
}

// 重写"加载广告"按钮事件
- (void)loadAdBtn1Action {
    NSLog(@"点击了加载广告按钮");
    
    // 1. 初始化插屏广告对象
    self.advanceInterstitial = [[AdvanceInterstitial alloc] initWithAdspotId:@"10000034"
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


- (void)dealloc {
    NSLog(@"%s",__func__);

}

@end
