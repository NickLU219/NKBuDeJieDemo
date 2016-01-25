//
//  NKFriendTrendsViewController.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/22.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKFriendTrendsViewController.h"
#import "NKRecomendViewController.h"
#import "NKLoginRegisterViewController.h"

@interface NKFriendTrendsViewController ()

@end

@implementation NKFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";

    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];

    self.view.backgroundColor = GlobalBGColor;
}


- (void)friendClick {
    NKLodFunc;
    NKRecomendViewController *recomend = [[NKRecomendViewController alloc] init];

    [self.navigationController pushViewController:recomend animated:YES];
}

- (IBAction)loginRegister {
    NKLoginRegisterViewController *loginRegister = [NKLoginRegisterViewController new];

    [self presentViewController:loginRegister animated:YES completion:nil];
    
}

@end
