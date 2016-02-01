//
//  NKTopicVideoView.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/27.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKTopicVideoView.h"
#import "NKTopic.h"
#import <UIImageView+WebCache.h>
#import "NKShowPictureViewController.h"
#import "VideoPlayView.h"

@interface NKTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (strong, nonatomic) VideoPlayView *videoPlayView;

@end
@implementation NKTopicVideoView
+ (instancetype)videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
//    self.videoPlayView = [VideoPlayView videoPlayView];
//    self.videoPlayView.hidden = YES;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVideo)]];
}
- (IBAction)playVideo {
    
    NKShowPictureViewController *showPicture = [[NKShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    showPicture.video = YES;

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(NKTopic *)topic {
    _topic = topic;

    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];

    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放", topic.playcount];

    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", minute, second];
}
@end
