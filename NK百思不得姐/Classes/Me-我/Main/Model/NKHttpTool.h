//
//  NKHttpTool.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKHttpTool : NSObject
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
