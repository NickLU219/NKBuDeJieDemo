//
//  NKTopic.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/26.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKTopic.h"
#import <MJExtension.h>

@implementation NKTopic {
    CGFloat _cellHeight;
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}
- (NSString *)create_time {
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];

    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];

            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}


- (CGFloat)cellHeight {
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(NKScreenW - 4 * NKTopicCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;

        // cell的高度
        // 文字部分的高度
        _cellHeight = NKTopicCellTextY + textH + NKTopicCellMargin;

        // 根据段子的类型来计算cell的高度
        if (self.type == NKTopicTypePicture) { // 图片帖子
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 显示显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= NKTopicCellPictureMaxH) { // 图片高度过长
                pictureH = NKTopicCellPictureBreakH;
                self.bigPicture = YES; // 大图
            }

            // 计算图片控件的frame
            CGFloat pictureX = NKTopicCellMargin;
            CGFloat pictureY = NKTopicCellTextY + textH + NKTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);

            _cellHeight += pictureH + NKTopicCellMargin;
        } else if (self.type == NKTopicTypeVoice) { // 声音帖子
            CGFloat voiceX = NKTopicCellMargin;
            CGFloat voiceY = NKTopicCellTextY + textH + NKTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);

            _cellHeight += voiceH + NKTopicCellMargin;
        } else if (self.type == NKTopicTypeVideo) { //视频帖子
            CGFloat videoX = NKTopicCellMargin;
            CGFloat videoY = NKTopicCellTextY + textH + NKTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);

            _cellHeight += videoH + NKTopicCellMargin;
        }

        // 底部工具条的高度
        _cellHeight += NKTopicCellBottomBarH + NKTopicCellMargin;
    }
    return _cellHeight;
}

@end
