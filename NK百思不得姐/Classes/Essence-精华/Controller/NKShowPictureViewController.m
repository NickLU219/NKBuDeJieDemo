//
//  NKShowPictureViewController.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/26.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKShowPictureViewController.h"
#import "NKTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "NKProgressView.h"
#import "VideoPlayView.h"

@interface NKShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NKProgressView *progressView;

/**  video */
@property (nonatomic, weak) VideoPlayView *videoView;
@end

@implementation NKShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加视频图片
    self.isVideo? [self addVideoView]: [self addPicture];

}

- (void)addVideoView {
    self.progressView.hidden = YES;

    self.videoView = [VideoPlayView videoPlayView];
    self.imageView.hidden = YES;
    self.videoView.frame = CGRectMake(0, 200, NKScreenW, NKScreenW * 9 / 16);
    [self.view addSubview:self.videoView];

    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.topic.videouri]];
    self.videoView.playerItem = item;
}

- (void)addPicture {
    // 添加图片
    self.imageView = [[UIImageView alloc] init];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:self.imageView];
    //    self.imageView = imageView;

    // 图片尺寸
    CGFloat pictureW = NKScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > NKScreenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        self.imageView.size = CGSizeMake(pictureW, pictureH);
        self.imageView.centerY = NKScreenH * 0.5;
    }

    [self.progressView setProgress:self.topic.pictureProgress animated:NO];

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress animated:NO];

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back {
    self.videoView.playerItem = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    if (!self.imageView.image) {
        [SVProgressHUD showErrorWithStatus:@"还没有下载好~"];
        return;
    }
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}

@end
