//
//  NKCommentViewController.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/28.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKCommentViewController.h"
#import "NKTopicCell.h"
#import "NKTopic.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "NKComment.h"
#import <MJExtension.h>
#import "NKCommentHeaderView.h"
#import "NKCommentCell.h"

static NSString * const NKCommentId = @"comment";
@interface NKCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/** 工具条底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) NKComment *saved_top_cmt;
/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation NKCommentViewController
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [self setupBasic];

    [self setupHeader];

    [self setupRefresh];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadMoreComments
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    // 页码
    NSInteger page = self.page + 1;

    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    NKComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;

    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // 最新评论
        NSArray *newComments = [NKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];

        // 页码
        self.page = page;

        // 刷新数据
        [self.tableView reloadData];

        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewComments {
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params  progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // 最热评论
        self.hotComments = [NKComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];

        // 最新评论
        self.latestComments = [NKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 页码
        self.page = 1;

        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];

        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setupHeader {
    // 创建header
    UIView *header = [[UIView alloc] init];

    // 清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    // 添加cell
    NKTopicCell *cell = [NKTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(NKScreenW, self.topic.cellHeight);
    [header addSubview:cell];

    // header的高度
    header.height = self.topic.cellHeight + NKTopicCellMargin;

    // 设置header
    self.tableView.tableHeaderView = header;
}

- (void)setupBasic {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"  " highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    // cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    // 背景色
    self.tableView.backgroundColor = GlobalBGColor;

    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NKCommentCell class]) bundle:nil] forCellReuseIdentifier:NKCommentId];


    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, NKTopicCellMargin, 0);
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSapce.constant = NKScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画 及时刷新
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    // 恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }

    [self.manager invalidateSessionCancelingTasks:YES];
}



/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (NKComment *)commentInIndexPath:(NSIndexPath *)indexPath {
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;

    if (hotCount) return 2; // 有"最热评论" + "最新评论" 2组
    if (latestCount) return 1; // 有"最新评论" 1 组
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;

    // 隐藏尾部控件
    tableView.mj_footer.hidden = (latestCount == 0);

    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }

    // 非第0组
    return latestCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 先从缓存池中找header
    NKCommentHeaderView *header = [NKCommentHeaderView headerViewWithTableView:tableView];

    // 设置label的数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NKCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NKCommentId];

    cell.comment = [self commentInIndexPath:indexPath];


    return cell;
}

@end
