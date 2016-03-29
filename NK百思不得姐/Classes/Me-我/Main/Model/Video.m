//
//  video.m
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "Video.h"
#import "Play.h"
#import "Categorie.h"
#import "NKCategoriesTimeViewController.h"
#import "NKCategoriesShareViewController.h"

@implementation Video
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"playInfo" : [Play class]
             };
}
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"videoDescription" : @"description"};
}


/**
 *  	请求路径
 */
+ (NSString *)toPathFromCategorie
{
    return @"http://baobab.wandoujia.com/api/v1/videos?";
}

/**
 *  	请求参数
 */
+ (NSDictionary *)toParameterFromCategorie:(Categorie *)categorie WithController:(id)controller Withlength:(NSUInteger)length;
{
    NSMutableDictionary *Parameter = [NSMutableDictionary dictionary];
    Parameter[@"num"] = @"10";
    Parameter[@"categoryName"] = categorie.name;
    if ([controller isKindOfClass:[NKCategoriesTimeViewController class]]) {
        Parameter[@"strategy"] = @"date";
    }else if ([controller isKindOfClass:[NKCategoriesShareViewController class]]){
        Parameter[@"strategy"] = @"shareCount";
    }
    Parameter[@"start"] = [NSString stringWithFormat:@"%lu",(unsigned long)length];
    return Parameter;
}
@end
