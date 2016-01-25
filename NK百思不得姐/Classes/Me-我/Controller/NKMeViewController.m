//
//  NKMeViewController.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/22.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKMeViewController.h"

@interface NKMeViewController ()

@end

@implementation NKMeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    // 设置导航栏标题
    self.navigationItem.title = @"我的";

    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];

    self.view.backgroundColor = GlobalBGColor;
}

- (void)settingClick
{
    NKLodFunc;
}

- (void)moonClick
{
    NKLodFunc;
}

@end
