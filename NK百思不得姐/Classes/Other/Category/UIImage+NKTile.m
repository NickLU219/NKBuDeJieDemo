//
//  UIImage+NKTile.m
//  WeatherForecast
//
//  Created by 陆金龙 on 16/1/16.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "UIImage+NKTile.h"

@implementation UIImage (NKTile)
- (UIImage *)OriginImageScaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸

    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];

    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return scaledImage;   //返回的就是已经改变的图片
}
@end
