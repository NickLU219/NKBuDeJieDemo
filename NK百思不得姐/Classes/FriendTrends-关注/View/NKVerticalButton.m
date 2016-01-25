//
//  NKVerticalButton.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/25.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKVerticalButton.h"

@implementation NKVerticalButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)awakeFromNib {
    [self setup];
}


- (void)layoutSubviews {
    [super layoutSubviews];

    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;

    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}


@end
