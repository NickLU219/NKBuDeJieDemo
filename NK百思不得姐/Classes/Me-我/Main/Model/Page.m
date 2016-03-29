//
//  DaliyList.m
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "Page.h"
#import "NSDate+DateTools.h"
#import "Daily.h"

@implementation Page
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"dailyList" : [Daily class]
             };
}



+ (NSString *)toPath
{
    return @"http://baobab.wandoujia.com/api/v1/feed?";
}

+ (NSDictionary *)toParameterWith:(NSDate *)date;
{
    NSMutableDictionary *Parameter = [NSMutableDictionary dictionary];
    Parameter[@"num"] = @"10";
    if (!date) {
        Parameter[@"date"] = @"20150902";
        return Parameter;
    }
    NSTimeZone *zone   = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate  = [date  dateByAddingTimeInterval: interval];
    // 设置日期格式
    NSString *dateString = [localDate formattedDateWithFormat:@"YYYYMMdd"];
    Parameter[@"date"] = dateString;
    return Parameter;
}

+ (NSDictionary *)toParameterWithSrt:(NSString *)str
{
    NSMutableDictionary *Parameter = [NSMutableDictionary dictionary];
    Parameter[@"num"] = @"10";
    if (!str) {
        Parameter[@"date"] = @"20160218";
        return Parameter;
    }
    Parameter[@"date"] = str;
    return Parameter;
}
@end
