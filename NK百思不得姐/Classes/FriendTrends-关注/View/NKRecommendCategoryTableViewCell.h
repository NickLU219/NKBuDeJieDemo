//
//  NKRecommendCategoryTableViewCell.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/24.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NKRecommendCategory;
@interface NKRecommendCategoryTableViewCell : UITableViewCell

/** 类别模型 */
@property (nonatomic, strong) NKRecommendCategory *category;
@end
