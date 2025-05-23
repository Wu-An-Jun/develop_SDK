//
//  AppDelegate.m
//  AdvanceSDK
//
//  Created by Cheng455153666 on 02/27/2020.
//  Copyright (c) 2020 Cheng455153666. All rights reserved.
//

#import "AppDelegate.h"
# if __has_include(<ABUAdSDK/ABUAdSDK.h>)
#import <ABUAdSDK/ABUAdSDK.h>
#else
//#import <Ads-Mediation-CN/ABUAdSDK.h>
#endif


#import "ViewController.h"
#import <AdvanceSplash.h>
#import <newios_sdk/AdvanceSplash.h>
#import <AdvSdkConfig.h>
#import <AdvBayesSDKConfig.h>

#define kPublicKey  @"用文本编辑打开pub_for_sdk.cer即可获取"

#define kPublicForApiKey @"用文本编辑打开public_for_api.pem即可获取"

#define kDevId @""
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

@interface AppDelegate () <AdvanceSplashDelegate>
@property(strong,nonatomic) AdvanceSplash *advanceSplash;

@end

@implementation AppDelegate

#pragma 开始集成前 请务必阅读文档中的注意事项及Checklist https://github.com/bayescom/AdvanceSDK
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        appearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        appearance.backgroundColor = [UIColor whiteColor];
        nav.navigationBar.scrollEdgeAppearance = appearance;
        nav.navigationBar.standardAppearance = appearance;
    }
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
//    [AdvSdkConfig shareInstance].appId = @"100008";
    [AdvSdkConfig shareInstance].appId = @"102768";
    [AdvBayesSDKConfig setUserAgent:@"ua"];
    [AdvBayesSDKConfig setAAIDWithMediaId:@"media001" mediaSecret:@"243835763"];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 请现在 plist 文件中配置 NSUserTrackingUsageDescription
    /*
     <key>NSUserTrackingUsageDescription</key>
     <string>该ID将用于向您推送个性化广告</string>
     */
    // 项目需要适配http
    
    /*
     <key>NSAppTransportSecurity</key>
     <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
     </dict>
     */
    // 调试阶段尽量用真机, 以便获取idfa, 如果获取不到idfa, 则打开idfa开关
    // iphone 打开idfa 开关的的过程:设置 -> 隐私 -> 跟踪 -> 允许App请求跟踪
    __block NSString *idfa = @"";
    ASIdentifierManager *manager = [ASIdentifierManager sharedManager];
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                idfa = [[manager advertisingIdentifier] UUIDString];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // do something
            });
        }];
    }else{
        if ([manager isAdvertisingTrackingEnabled]) {
            idfa = [[manager advertisingIdentifier] UUIDString];
        }

    }
    
}


@end
