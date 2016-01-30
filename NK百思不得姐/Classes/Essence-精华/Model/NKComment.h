//
//  NKComment.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/28.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NKUser;
@interface NKComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) NKUser *user;

@end
