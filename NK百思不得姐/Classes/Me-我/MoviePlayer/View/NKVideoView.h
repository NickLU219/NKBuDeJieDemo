//
//  NKVideoView.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@class NKVideoView;

@protocol videoViewDelegate <NSObject>
@optional
- (void)playerViewZoomButtonClicked:(NKVideoView *)view;
- (void)playerFinishedPlayback:(NKVideoView *)view;
- (void)pageBackButtonAction;
@end

@interface NKVideoView : UIView

@property (assign, nonatomic) id <videoViewDelegate> delegate;
@property (strong, nonatomic) NSURL *contentURL;
@property (strong, nonatomic) AVPlayer *moviePlayer;


@property (assign, nonatomic) BOOL shouldShowHideParentNavigationBar;
@property (assign, nonatomic) BOOL shouldPlayAudioOnVibrate;

@property (nonatomic, copy) NSString *titleName;

-(instancetype)initWithFrame:(CGRect)frame contentURL:(NSURL*)contentURL;
-(instancetype)initWithFrame:(CGRect)frame playerItem:(AVPlayerItem*)playerItem;
-(void)play;
-(void)pause;
-(void)setupConstraints;

@end
