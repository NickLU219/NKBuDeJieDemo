//
//  NSString+FormatterDate.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FormatterDate)
/**
 *  - MMM. dd -
 */
- (NSString *)formatterDateToMMMdd;

/**
 *  时间格式化 
 */
- (NSString *)formatterDateToYYMMDDToDay;

/**
 *  时间格式化 含1000
 */
- (NSString *)formatterDateToYYMMDDTo1000;
/**
 *  时间格式化昨天 不含1000
 */
- (NSString *)formatterDateToYYMMDDToYestday;
@end
