//
//  NKMainTabBar.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainTabBarDelegate <NSObject>

@optional
- (void)mainTabBar:(UIView *)tabar didSelectBtnfrom:(NSInteger)from to:(NSInteger)to;
@end

@interface NKMainTabBar : UITabBar
@property (nonatomic ,weak) id<MainTabBarDelegate> delegate;
- (void)addTabBarBtnWithName:(NSString *)name;
@end
