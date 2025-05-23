## 开屏广告

开屏广告需要传入当前ViewController作为参数，开屏广告展示时间统一为5秒钟，开发者可以设置统一的广告请求超时时间，超时时间默认为5秒。

### 代理方法说明

| 代理方法                                                         | 介绍                                   |
|------------------------------------------------------------------|----------------------------------------|
| - didFinishLoadingADPolicyWithSpotId:                             | 广告策略服务加载成功                   |
| - didFailLoadingADSourceWithSpotId: error: description:           | 广告策略或者渠道广告加载失败           |
| - didStartLoadingADSourceWithSpotId: sourceId:                    | 广告位中某一个广告源开始加载广告<br>sourceId :将要加载的渠道id |
| - didFinishLoadingSplashADWithSpotId:                             | 开屏广告数据拉取成功                   |
| - splashDidShowForSpotId: extra:                                  | 开屏广告展示成功                       |
| - splashDidClickForSpotId: extra:                                 | 开屏广告被点击                         |
| - splashDidCloseForSpotId: extra:                                 | 开屏广告被关闭                         |

### 代码示例

```objective-c
#import "DemoSplashViewController.h"
#import "DemoUtils.h"
#import <AdvanceSDK/AdvanceSplash.h>

@interface DemoSplashViewController () <AdvanceSplashDelegate>
@property(strong,nonatomic) AdvanceSplash *advanceSplash;
@end

@implementation DemoSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.initDefSubviewsFlag = YES;
    self.adspotIdsArr = @[
        @{@"addesc": @"mediaId-adspotId", @"adspotId": @"10033-200034"},
    ];
    self.btn1Title = @"加载并显示广告";
}

- (void)loadAdBtn1Action {
    if (![self checkAdspotId]) { return; }
    self.advanceSplash = [[AdvanceSplash alloc] initWithMediaId:self.mediaId
                                                       adspotId:self.adspotId
                                                 viewController:self];
    self.advanceSplash.delegate = self;
    self.advanceSplash.logoImage = [UIImage imageNamed:@"640-100"];
    self.advanceSplash.backgroundImage = [UIImage imageNamed:@"LaunchImage_img"];
    [self.advanceSplash loadAd];
}

// MARK: ======================= AdvanceSplashDelegate =======================

/// 广告策略服务加载成功
- (void)didFinishLoadingADPolicyWithSpotId:(NSString *)spotId {
    NSLog(@"广告策略服务加载成功 spotId: %@", spotId);
}

/// 广告策略或者渠道广告加载失败
- (void)didFailLoadingADSourceWithSpotId:(NSString *)spotId error:(NSError *)error description:(NSDictionary *)description {
    NSLog(@"广告加载失败 spotId: %@, error: %@, description: %@", spotId, error, description);
}

/// 广告位中某一个广告源开始加载
- (void)didStartLoadingADSourceWithSpotId:(NSString *)spotId sourceId:(NSString *)sourceId {
    NSLog(@"广告源开始加载 spotId: %@, sourceId: %@", spotId, sourceId);
}

/// 开屏广告数据拉取成功
- (void)didFinishLoadingSplashADWithSpotId:(NSString *)spotId {
    NSLog(@"广告数据拉取成功 spotId: %@", spotId);
}

/// 开屏广告展示成功
- (void)splashDidShowForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告展示成功 spotId: %@, extra: %@", spotId, extra);
}

/// 开屏广告被点击
- (void)splashDidClickForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告被点击 spotId: %@, extra: %@", spotId, extra);
}

/// 开屏广告被关闭
- (void)splashDidCloseForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告被关闭 spotId: %@, extra: %@", spotId, extra);
}

@end
