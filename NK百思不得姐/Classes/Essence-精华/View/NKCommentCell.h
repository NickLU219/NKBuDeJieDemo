//
//  NKCommentCell.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/29.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKComment;
@interface NKCommentCell : UITableViewCell

/** 评论 */
@property (nonatomic, strong) NKComment *comment;
@end
