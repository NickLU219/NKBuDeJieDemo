//
//  NSString+FormatterDate.m
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NSString+FormatterDate.h"
#import "NSDate+DateTools.h"

@implementation NSString (FormatterDate)
- (NSString *)formatterDateToMMMdd
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000.0];
    NSString *dateString = [currentDate formattedDateWithFormat:@"- MMM. dd -" locale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    return dateString;
}


- (NSString *)formatterDateToYYMMDDToDay
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[self longLongValue] / 1000];
    // 设置日期格式
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

- (NSString *)formatterDateToYYMMDDTo1000
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]];
    // 设置日期格式
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

- (NSString *)formatterDateToYYMMDDToYestday
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[self longLongValue] / 1000];
    // 设置日期格式
    NSDate *lastDate =[currentDate dateBySubtractingDays:1];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:lastDate];
    return dateString;
}
@end
