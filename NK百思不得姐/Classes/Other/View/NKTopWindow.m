//
//  NKTopWindow.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/29.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKTopWindow.h"

@implementation NKTopWindow

static UIWindow *window_;

+ (void)initialize {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.userInteractionEnabled = NO;
    window_ = [[UIWindow alloc] init];
    window_.rootViewController = vc;
    window_.frame = CGRectMake(0, 0, NKScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show {
    window_.hidden = NO;
}

+ (void)hide {
    window_.hidden = YES;
}

/**
 * 监听窗口点击
 */
+ (void)windowClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview {
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }

        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

@end
