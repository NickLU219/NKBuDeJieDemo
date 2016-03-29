//
//  UIBarButtonItem+itemLeftAndRightBtn.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AddImageItem)
/**
 *  创建含有高亮的图片Item
 */
+ (UIBarButtonItem *)ItemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

/**
 *  创建图片Item并判断是否需要渲染.
 *  @param rendering 是否需要渲染
 *
 *  @return UIBarButtonItem
 */
- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action rendering:(BOOL)rendering;
@end
