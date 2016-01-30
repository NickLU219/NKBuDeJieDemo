//
//  NKCommentHeaderView.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/29.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKCommentHeaderView.h"


@interface NKCommentHeaderView()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation NKCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    NKCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[NKCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = GlobalBGColor;

        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color(67, 67, 67);
        label.width = 200;
        label.x = NKTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];

    self.label.text = title;
}


@end
