//
//  NKCommentHeaderView.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/29.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKCommentHeaderView : UITableViewHeaderFooterView
/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
