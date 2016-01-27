//
//  NKRecommendCategory.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/24.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKRecommendCategory : NSObject
/** id */
@property (nonatomic, assign) NSInteger ID;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/**  对应用户数 */
@property (nonatomic, strong) NSMutableArray *users;
/**  当前页码 */
@property (nonatomic, assign) NSInteger current_page;
/**  总数 */
@property (nonatomic, assign) NSInteger total;
@end
