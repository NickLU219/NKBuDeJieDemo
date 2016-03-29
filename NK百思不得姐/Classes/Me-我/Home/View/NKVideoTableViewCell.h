//
//  NKVideoTableViewCell.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Video;
@interface NKVideoTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) Video *video;
@end


#define CellH ([[UIScreen mainScreen] bounds].size.width * 0.6)