//
//  UIView+Extension.h
//  微博V1
//
//  Created by 陆金龙 on 15/11/5.
//  Copyright © 2015年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/**  是否真正展示在界面上 */
@property (nonatomic, assign) BOOL isShowingOnKeyWindow;
@end
