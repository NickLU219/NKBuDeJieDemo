//
//  NKTextField.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/25.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKTextField.h"

static NSString * const NKPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation NKTextField

- (void)awakeFromNib
{
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;

    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:NKPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:NKPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}


@end
