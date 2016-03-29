//
//  Daily.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface Daily : NSObject
/**
 *     NSInteger 数量
 */
@property (nonatomic, assign) NSInteger total;
/**
 *  	NSArray	视频组模型>Video。
 */
@property (nonatomic, strong) NSArray *videoList;
/**
 *  	string	时间(从1970  *1000)。
 */
@property (nonatomic,copy) NSString *date;



@end
