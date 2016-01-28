
//
//  NKTopicVoiceView.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/27.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKTopicVoiceView.h"
#import "NKTopic.h"
#import <UIImageView+WebCache.h>
#import "NKShowPictureViewController.h"

@interface NKTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end
@implementation NKTopicVoiceView

+ (instancetype)voiceView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;

    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture {
    NKShowPictureViewController *showPicture = [[NKShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(NKTopic *)topic {
    _topic = topic;

    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];

    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放", topic.playcount];

    // 时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", minute, second];
}
@end
