//
//  NSString+SizeWithString.m
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NSString+SizeWithString.h"

@implementation NSString (SizeWithString)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)MaxW
{
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc]init];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MaxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
@end
