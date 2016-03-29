//
//  NKMainTabBarViewController.m
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKMainTabBarViewController.h"
#import "NKHomeTableViewController.h"
#import "NKCategoryCollectionViewController.h"
#import "NKMainTabBar.h"
#import "UIView+XYWH.h"

@interface NKMainTabBarViewController () <MainTabBarDelegate>

@end

@implementation NKMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewController];
}

- (void)setupChildViewController {
    [self sharedTabBar];
    NKHomeTableViewController *home = [[NKHomeTableViewController alloc] init];
    [self addChildVC:home withTitle:@"每日精选"];
    NKCategoryCollectionViewController *category = [[NKCategoryCollectionViewController alloc] init];
    [self addChildVC:category withTitle:@"往期分类"];
}

static NKMainTabBar *myTabBar;
static dispatch_once_t onceToken;
- (void)sharedTabBar {
    dispatch_once(&onceToken, ^{
        // 自定义TabBar
        myTabBar = [[NKMainTabBar alloc]initWithFrame:self.tabBar.frame];
        // 隐藏系统tabBar
        self.tabBar.hidden = YES;
        // 1.改变UITransitionView 高度
        myTabBar.delegate = self;
//        [self.view addSubview:myTabBar];
    });

}
- (void)addChildVC:(UIViewController *)childVc withTitle:(NSString *)title {
    [myTabBar addTabBarBtnWithName:title];
    // 创建导航控制器,子控制器为childVc
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];

    childVc.title                              = title;
    NSMutableDictionary *Attributes            = [NSMutableDictionary dictionary];
    Attributes[NSForegroundColorAttributeName] = NKColor(141, 200, 81);
    Attributes[NSFontAttributeName]            = Font_ChinaBold(20);
    [childVc.tabBarItem setTitleTextAttributes:Attributes forState:UIControlStateNormal];

    // TabBar控制器添加子控制器
    [self addChildViewController:nav];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return  UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

#pragma mark - mainTabBarDelegate 
- (void)mainTabBar:(UIView *)tabar didSelectBtnfrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}



@end
