//
//  Play.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Play : NSObject
/**
 *  	string	清晰度
 */
@property (nonatomic, copy) NSString *name;
/**
 *  	string	清晰度类型。
 */
@property (nonatomic, copy) NSString *type;
/**
 *  	string	视频地址。
 */
@property (nonatomic, copy) NSString *url;

@end
