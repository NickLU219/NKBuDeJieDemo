//
//  NKEssenceViewController.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/22.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKEssenceViewController.h"
#import "NKRecommendTagsViewController.h"


@interface NKEssenceViewController ()

@end

@implementation NKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

    self.view.backgroundColor = GlobalBGColor;
}

- (void)tagClick {
//    NKLog(@"%s",__func__);
    [self.navigationController pushViewController:[[NKRecommendTagsViewController alloc]init] animated:YES];

}

@end
