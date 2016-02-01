//
//  VideoPlayView.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/28.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol VideoPlayViewDelegate <NSObject>

@optional
- (void)videoplayViewSwitchOrientation:(BOOL)isFull;

@end

@interface VideoPlayView : UIView

+ (instancetype)videoPlayView;

@property (weak, nonatomic) id<VideoPlayViewDelegate> delegate;

@property (nonatomic, strong) AVPlayerItem *playerItem;

@end
