//
//  NKCommentViewController.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/28.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NKTopic;
@interface NKCommentViewController : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) NKTopic *topic;

@end
