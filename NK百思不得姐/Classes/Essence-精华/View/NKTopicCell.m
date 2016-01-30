//
//  NKTopicCell.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/26.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKTopicCell.h"
#import "NKTopic.h"
#import <UIImageView+WebCache.h>
#import "NKTopicPictureView.h"
#import "NKTopicVoiceView.h"
#import "NKTopicVideoView.h"
#import "NKComment.h"
#import "NKUser.h"


@interface NKTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 文字标签*/
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property (nonatomic, weak) NKTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property (nonatomic, weak) NKTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property (nonatomic, weak) NKTopicVideoView *videoView;
/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;


@end
@implementation NKTopicCell

+ (instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (NKTopicPictureView *)pictureView {
    if (!_pictureView) {
        NKTopicPictureView *pictureView = [NKTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (NKTopicVoiceView *)voiceView {
    if (!_voiceView) {
        NKTopicVoiceView *voiceView = [NKTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (NKTopicVideoView *)videoView {
    if (!_videoView) {
        NKTopicVideoView *videoView = [NKTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(NKTopic *)topic {
    _topic = topic;

    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;

    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

    // 设置名字
    self.nameLabel.text = topic.name;

    // 设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;

    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];

    //设置文字
    self.text_label.text = topic.text;

    //根据帖子类型，添加不同pictureView
    if (topic.type == NKTopicTypePicture) { // 图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;

        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (topic.type == NKTopicTypeVoice) { // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;

        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == NKTopicTypeVideo) { //视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;

        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (topic.type == NKTopicTypeWord) {
        self.pictureView.hidden = YES;

        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }

    // 处理最热评论
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%ld", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = NKTopicCellMargin;
    frame.size.width -= 2 * NKTopicCellMargin;
    frame.size.height = self.topic.cellHeight - NKTopicCellMargin;
    frame.origin.y += NKTopicCellMargin;

    [super setFrame:frame];
}

- (IBAction)more {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];
}
@end
