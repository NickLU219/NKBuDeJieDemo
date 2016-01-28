//
//  NKTopicVideoView.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/27.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKTopic;

@interface NKTopicVideoView : UIView

+ (instancetype)videoView;


/** 帖子数据 */
@property (nonatomic, strong) NKTopic *topic;
@end
