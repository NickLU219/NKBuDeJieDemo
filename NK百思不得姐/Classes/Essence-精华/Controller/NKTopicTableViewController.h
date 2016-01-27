//
//  NKTopicTableViewController.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/26.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NKTopicTableViewController : UITableViewController
/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) NKTopicType type;
@end
