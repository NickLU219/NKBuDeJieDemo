//
//  NKCommentCell.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/29.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKCommentCell.h"
#import "NKComment.h"
#import <UIImageView+WebCache.h>
#import "NKUser.h"

@interface NKCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation NKCommentCell

- (void)setComment:(NKComment *)comment
{
    _comment = comment;

    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexView.image = [comment.user.sex isEqualToString:NKUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%ld", comment.like_count];

    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%ld''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = NKTopicCellMargin;
    frame.size.width -= 2 * NKTopicCellMargin;

    [super setFrame:frame];
}

- (void)awakeFromNib {

    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}


@end
