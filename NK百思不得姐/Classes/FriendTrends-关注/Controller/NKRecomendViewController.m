//
//  NKRecomendViewController.m
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/23.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKRecomendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "NKRecommendCategoryTableViewCell.h"
#import <MJExtension.h>
#import "NKRecommendCategory.h"
#import "NKRecommendUser.h"
#import "NKRecommendUserTableViewCell.h"
#import <MJRefresh.h>


#define NKSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

#define checkFooterState \
self.userTableView.mj_footer.hidden = (NKSelectedCategory.users.count == 0); \
NKSelectedCategory.users.count == NKSelectedCategory.total ? \
[self.userTableView.mj_footer endRefreshingWithNoMoreData] : \
[self.userTableView.mj_footer endRefreshing];


@interface NKRecomendViewController () <UITableViewDataSource, UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray<NKRecommendCategory *> *categories;

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/**  请求的参数 */
@property (nonatomic, strong) NSDictionary *params;

/**  AFN的请求 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation NKRecomendViewController

static NSString * const NKCategoryId = @"category";
static NSString * const NKUserId = @"user";

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 控件的初始化
    [self setupTableView];

    //设置刷新控件
    [self setupRefresh];

    [self loadCategories];
}

- (void)dealloc {
    //停止所有请求
    [self.manager.operationQueue cancelAllOperations];
}

- (void)loadCategories {
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];

        // 服务器返回的JSON数据
        self.categories = [NKRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        // 刷新表格
        [self.categoryTableView reloadData];

        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];

        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"网络似乎不是很好哦~"];
    }];
}

- (void)setupTableView {
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([NKRecommendCategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:NKCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([NKRecommendUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:NKUserId];

    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;

    // 设置标题
    self.title = @"推荐关注";

    // 设置背景色
    self.view.backgroundColor = GlobalBGColor;
}

- (void)setupRefresh {
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];

    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}
#pragma mark - 加载更多数据
- (void)loadNewUsers {
    NKRecommendCategory *category = NKSelectedCategory;

    // 发送请求给服务器, 加载右侧的数据
    category.current_page = 1;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(category.current_page);

    self.params = params;


    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *users = [NKRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //下拉刷新时，清空数组
        [category.users removeAllObjects];

        [category.users addObjectsFromArray:users];
        //保存总数
        category.total = [responseObject[@"total"] integerValue];

        if (self.params != params) {
            return ;
        }

        // 刷新右边的表格
        [self.userTableView reloadData];
        //结束刷新
        [self.userTableView.mj_header endRefreshing];

        //监听footer
        checkFooterState

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NKLog(@"%@", error);
        if (self.params != params) {
            return ;
        }
        //结束刷新
        [self.userTableView.mj_header endRefreshing];

        [SVProgressHUD showErrorWithStatus:@"网络似乎不太好哦~"];
    }];
}
- (void)loadMoreUsers {

    NKRecommendCategory *category = NKSelectedCategory;

    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(++category.current_page);

    self.params = params;


    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *users = [NKRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:users];

        if (self.params != params) {
            return;
        }

        // 刷新右边的表格
        [self.userTableView reloadData];

        //监听footer
        checkFooterState

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NKLog(@"%@", error);
        if (self.params != params) {
            return;
        }
        //结束刷新
        [self.userTableView.mj_header endRefreshing];

        [SVProgressHUD showErrorWithStatus:@"网络似乎不太好哦~"];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //左边表格
    if (tableView == self.categoryTableView)
        return self.categories.count;
    //监听FOOTER
    checkFooterState
    // 右边的用户表格
    return NKSelectedCategory.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) { // 左边的类别表格
        NKRecommendCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NKCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        NKRecommendUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NKUserId];

        cell.user = NKSelectedCategory.users[indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];


    NKRecommendCategory *c = self.categories[indexPath.row];

    if (c.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    } else {
        [self.userTableView reloadData];

        [self.userTableView.mj_header beginRefreshing];
    }
}

@end
