//
//  NKRecommendCategory.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/24.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKRecommendCategory.h"

@implementation NKRecommendCategory
- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
