//
//  ViewController.m
//  AdvanceSDKDev
//
//  Created by CherryKing on 2020/4/9.
//  Copyright © 2020 bayescom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *dataArr;
@property (nonatomic, strong) UIImageView *logoImgV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聚合广告位";
    
    [self initSubviews];
    
    _dataArr = @[
        @{@"title":@"开屏", @"targetVCName": @"DemoSplashViewController"},
        @{@"title":@"Banner", @"targetVCName": @"DemoBannerViewController"},
        @{@"title":@"插屏", @"targetVCName": @"DemoInterstitialViewController"},
        @{@"title":@"激励视频", @"targetVCName": @"DemoRewardVideoViewController"},
        @{@"title":@"全屏视频", @"targetVCName": @"DemoFullScreenVideoController"},
        @{@"title":@"模版渲染信息流", @"targetVCName": @"DemoFeedExpressViewController"},
        @{@"title":@"自渲染信息流", @"targetVCName": @"DemoRenderFeedViewController"},
        @{@"title":@"自定义广告Demo", @"targetVCName": @"LDemoCustomAdViewController"},
//        @{@"title":@"Lzc创建的插屏广告", @"targetVCName": @"DemoInterstitialViewController_new2"},
    ];
    
    [_tableView reloadData];
}

- (void)initSubviews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kkScreenWidth, kkScreenHeight - kkNavigationBarHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

// MARK: UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    cell.textLabel.text = _dataArr[indexPath.row][@"title"];
    return cell;
}

// 页面跳转：当用户点击表格某一行时会调用这个方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 取出当前点击行对应的数据字典
//    当你点击表格的某一行时，系统会自动创建一个 NSIndexPath 对象，把你点击的那一行的行号（row）和分区号（section）赋值进去。
//    然后把这个 indexPath 作为参数传给 didSelectRowAtIndexPath 方法。
    NSDictionary *item = _dataArr[indexPath.row];
    
    // 2. 从数据字典中获取目标控制器的类名字符串
    NSString *vcName = item[@"targetVCName"];
    
    // 3. 通过类名字符串获取类对象（Class）
    Class vcClass = NSClassFromString(vcName);
    
    // 4. 创建目标控制器的实例对象
    UIViewController *vc = [[vcClass alloc] init];
    
    // 5. 设置新页面的标题（可选，便于导航栏显示）
    vc.title = item[@"title"];
    
    // 6. 使用导航控制器进行页面跳转（push到新页面）
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


@end
