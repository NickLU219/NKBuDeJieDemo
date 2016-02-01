//
//  NKShowPictureViewController.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/26.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKTopic;
@interface NKShowPictureViewController : UIViewController
/** 帖子 */
@property (nonatomic, strong) NKTopic *topic;

@property (strong, nonatomic) UIImageView *imageView;


/**  是否是视频 */
@property (nonatomic, assign, getter=isVideo) BOOL video;
@end
