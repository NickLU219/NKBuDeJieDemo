//
//  Daily.m
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "Daily.h"
#import "video.h"
#import "NSDate+DateTools.h"
@implementation Daily
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"videoList" : [Video class]
             };
}


@end
