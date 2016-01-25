//
//  NKRecommendTagsViewController.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/24.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKRecommendTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "NKRecommendTag.h"
#import <MJExtension.h>
#import "NKRecommendTagCell.h"


@interface NKRecommendTagsViewController ()
/**  标签数组 */
@property (nonatomic, strong) NSArray<NKRecommendTag *> *tags;
@end

static NSString * const NKTagsID = @"tag";

@implementation NKRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];

    [self loadTags];
}

- (void)setupTableView {
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GlobalBGColor;

    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NKRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:NKTagsID];
}

- (void)loadTags {
    //发送请求
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        //        NKLog(@"%@",responseObject);
        self.tags = [NKRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络似乎不太好哦~"];
        NSLog(@"%@",error.userInfo);
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NKRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:NKTagsID];

    cell.recommendTag = self.tags[indexPath.row];

    return cell;
}

@end
