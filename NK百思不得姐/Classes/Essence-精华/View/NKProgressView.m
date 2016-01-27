//
//  NKProgressView.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/26.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKProgressView.h"

@implementation NKProgressView

- (void)awakeFromNib {

    self.roundedCorners = 6;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    progress = (progress <= 0 ? 0 : progress);
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
}
@end
