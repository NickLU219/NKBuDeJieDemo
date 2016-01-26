//
//  NKPushGuideView.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/25.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKPushGuideView.h"

@implementation NKPushGuideView

+ (instancetype)guideView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
}
- (IBAction)close {

    [self removeFromSuperview];
}

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";

    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];

    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;

        NKPushGuideView *guideView = [NKPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];

        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //马上存储
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
