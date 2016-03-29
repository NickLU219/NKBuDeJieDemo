//
//  NKMainTabBar.m
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKMainTabBar.h"
#import "UIView+XYWH.h"
#import "NSString+SizeWithString.h"

#define TabBarH (35)
#define LineTopPading (5)

@interface NKMainTabBar ()
/** 上一次按钮 */
@property (nonatomic ,weak) UIButton *lastbarBtn;
/** 分割线 */
@property (nonatomic ,weak) UIView *lineView;

@end
@implementation NKMainTabBar
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = NKColorWithAlpha(250, 250, 250, 0.9);
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize oSize = [super sizeThatFits:size];
//    oSize.height += 30;
    return oSize;
}

- (void)addTabBarBtnWithName:(NSString *)name {
    // ==== 创建按钮
    UIButton *barBtn  = [[UIButton alloc]init];
    // 2.设置按钮就标题及选中颜色
    barBtn.titleLabel.font = Font_China(14);
    [barBtn setTitle:name forState:UIControlStateNormal];
    [barBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [barBtn setTitleColor:NKColor(140, 140, 140) forState:UIControlStateNormal];

    // ==== 添加分割线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = NKColor(100, 100, 100);
    [barBtn addSubview:lineView];

    // 添加点击事件 (按下生效)
    [barBtn addTarget:self action:@selector(barBtnClick:) forControlEvents:UIControlEventTouchDown];

    // 添加按钮到NKTabBar
    [self addSubview:barBtn];
    if (self.subviews.count == 1) {
        [self barBtnClick:barBtn]; // 默认第一个按钮
    }
}

- (void)barBtnClick:(UIButton *)barBtn {
    if ([self.delegate respondsToSelector:@selector(mainTabBar:didSelectBtnfrom:to:)]) {
        [self.delegate mainTabBar:self didSelectBtnfrom:self.lastbarBtn.tag to:barBtn.tag];
    }
    // 1.上一次选中状态恢复
    self.lastbarBtn.selected = NO;
    // 2.设置当前按钮状态
    barBtn.selected = YES;
    // 3.覆盖上一次选中状态
    self.lastbarBtn = barBtn;
}

/**
 *  重新布局
 */
- (void)layoutSubviews {
    [super layoutSubviews];

    NSInteger index = 0;
    for (int i = 0; i < self.subviews.count; i++) {

        UIButton *btn = self.subviews[i];
        if ([btn isKindOfClass:[UIButton class]]) {
            // 计算frame
            CGFloat barW = self.frame.size.width / 2;
            CGFloat barX = index * barW;
            CGFloat barY = 0;
            CGFloat BarH = self.frame.size.height;
            btn.frame = CGRectMake(barX, barY, barW, BarH);
            // 添加Tag为顺序
            btn.tag = index;
            index++;
            for (UIView *view in btn.subviews) {
                if([view isKindOfClass:[UIView class]] && i > 0) { // 如果是View,且不是首个
                    // 设置Line的Frame
                    view.width = 1;
                    view.height =  TabBarH - (LineTopPading * 2);
                    view.x = 1;
                    view.centerY = btn.centerY;}
                
            }
        }


    }
}
@end
