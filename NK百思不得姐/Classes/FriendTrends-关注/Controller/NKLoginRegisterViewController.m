//
//  NKLoginRegisterViewController.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/25.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKLoginRegisterViewController.h"

@interface NKLoginRegisterViewController ()
/** 登录框距离控制器view左边的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@end

@implementation NKLoginRegisterViewController

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)showLoginOrRegister:(UIButton *)button {
    // 退出键盘
    [self.view endEditing:YES];

    if (self.loginViewLeftMargin.constant == 0) { // 显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        button.selected = YES;
    } else { // 显示登录界面
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }

    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
