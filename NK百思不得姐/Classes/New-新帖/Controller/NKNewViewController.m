//
//  NKNewViewController.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/23.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKNewViewController.h"

@interface NKNewViewController ()

@end

@implementation NKNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

    self.view.backgroundColor = GlobalBGColor;
}

- (void)tagClick
{
    NKLodFunc;
}



@end
