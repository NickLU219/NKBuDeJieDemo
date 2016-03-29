//
//  Categorie.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categorie : NSObject
/** string	分类名称 */
@property (nonatomic, copy) NSString *name;

/** string	背景图片Url地址 */
@property (nonatomic, copy) NSString *bgPicture;



#pragma mark 请求参数
/** 请求路径 */
+ (NSString *)toPath;

/** 请求参数 */
+ (NSDictionary *)toParameter;
@end
