//
//  NKPublishView.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/27.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKPublishView.h"
#import "NKVerticalButton.h"
#import <POP.h>

static CGFloat const NKAnimationDelay = 0.05;
static CGFloat const NKSpringFactor = 8;
@interface NKPublishView ()

@end

@implementation NKPublishView
+ (instancetype)publishView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


static UIWindow *kWindow;
+ (void)show {
    // 创建窗口
    kWindow = [[UIWindow alloc] init];
    kWindow.frame = [UIScreen mainScreen].bounds;
    kWindow.backgroundColor = [[UIColor colorWithPatternImage:[[UIImage imageNamed:@"shareBottomBackground"] OriginImageScaleToSize:[UIScreen mainScreen].bounds.size]] colorWithAlphaComponent:0.9];
    kWindow.hidden = NO;

    // 添加发布界面
    NKPublishView *publishView = [NKPublishView publishView];
    publishView.frame = kWindow.bounds;
    [kWindow addSubview:publishView];
}

- (void)awakeFromNib {

    // 让控制器的view不能被点击
    self.userInteractionEnabled = NO;

    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];

    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (NKScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (NKScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        NKVerticalButton *button = [[NKVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];

        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - NKScreenH;

        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = NKSpringFactor;
        anim.springSpeed = NKSpringFactor;
        anim.beginTime = CACurrentMediaTime() + NKAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
    }

    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];

    // 标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = NKScreenW * 0.5;
    CGFloat centerEndY = NKScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - NKScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * NKAnimationDelay;
    anim.springBounciness = NKSpringFactor;
    anim.springSpeed = NKSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画执行完毕, 恢复点击事件
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

- (void)buttonClick:(UIButton *)button {
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            NKLog(@"发视频");
        } else if (button.tag == 1) {
            NKLog(@"发图片");
        }
    }];
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}


- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    self.userInteractionEnabled = NO;

    int beginIndex = 1;

    for (int i = beginIndex; i < self.subviews.count; i++) {
        UIView *subview = self.subviews[i];


        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + NKScreenH;

        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * NKAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];

        // 监听最后一个动画
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {

                [self removeFromSuperview];
                kWindow.hidden = YES;
//                kWindow = nil;

                !completionBlock ? : completionBlock();

            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self cancelWithCompletionBlock:nil];
}

@end
