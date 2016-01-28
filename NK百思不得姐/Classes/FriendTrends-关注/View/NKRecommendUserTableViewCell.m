//
//  NKRecommendUserTableViewCell.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/24.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKRecommendUserTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "NKRecommendUser.h"


@interface NKRecommendUserTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end
@implementation NKRecommendUserTableViewCell

- (void)setUser:(NKRecommendUser *)user {
    _user = user;

    self.screenNameLabel.text = user.screen_name;

    NSString *fans_count = nil;
    if (user.fans_count < 10000) {
        fans_count = [NSString stringWithFormat:@"%ld人关注", user.fans_count];
    } else { // 大于等于10000
        fans_count = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }

    self.fansCountLabel.text = fans_count;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
