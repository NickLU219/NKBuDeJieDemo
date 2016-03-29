//
//  NKCategoriesShareViewController.m
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKCategoriesShareViewController.h"
#import "MJRefresh.h"
#import "NKVideoTableViewCell.h"
#import "Video.h"
#import "Categorie.h"
#import "NKHttpTool.h"
#import "NKVideoPlayerViewController.h"
#import "MBProgressHUD+BM.h"
#import "MJExtension.h"

#import "UIView+XYWH.h"
#import "NKAutoFooter.h"

@interface NKCategoriesShareViewController ()
@property (nonatomic, strong) NSMutableArray *videoList;
@end

@implementation NKCategoriesShareViewController

- (void)viewDidLoad
{

    [self addVideoDate];

    //添加刷新控件
    [self addRefresh];
    // 初始化数据,自动下拉刷新


    // 取消分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;



}
- (void)addVideoDate
{
    __weak typeof(self) weakSelf = self;
    [NKHttpTool GET:[Video toPathFromCategorie] parameters:[Video toParameterFromCategorie:self.categorie WithController:self Withlength:self.videoList.count] success:^(id json) {
        // 获取数据[Video objectArrayWithKeyValuesArray:json[@"videoList"]];
        NSArray *array = json[@"videoList"];

        weakSelf.videoList = [Video mj_objectArrayWithKeyValuesArray:array];

        // 刷新表格
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
    }];
}
#pragma mark  - 添加刷新相关

/**
 *  添加刷新
 */

- (void)addRefresh
{
    // 添加上拉刷新
    NKAutoFooter *footer = [NKAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerWithRefreshingMore:)];
    footer.colseAutomaticallyAdjustsSuperViewInsets = YES;
    self.tableView.mj_footer = footer;
}

///**
// *  上拉加载更多
// */
- (void)footerWithRefreshingMore:(MJRefreshComponent *)refresh
{
    __weak typeof(self) weakSelf = self;
    [NKHttpTool GET:[Video toPathFromCategorie] parameters:[Video toParameterFromCategorie:self.categorie WithController:self Withlength:self.videoList.count] success:^(id json) {
        NSArray *array = json[@"videoList"];
        if(array.count == 0){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            // 获取数据
            [weakSelf.videoList addObjectsFromArray:[Video mj_objectArrayWithKeyValuesArray:array]];

            // 刷新表格
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];}
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark 数据源方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ;
    return self.videoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 创建模型
    NKVideoTableViewCell *cell = [NKVideoTableViewCell cellWithTableView:tableView];

    // 传递模型
    Video *video             = self.videoList[indexPath.row];
    cell.video               = video;

    return cell;
}
#pragma mark tableView代理方法
/**
 *  tableView行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建控制器
    NKVideoPlayerViewController *Vc = [[NKVideoPlayerViewController alloc]init];
    // 传递模型
    Video *video = self.videoList[indexPath.row];
    Vc.video = video;

    [self presentViewController:Vc animated:YES completion:nil];
}



#pragma mark 懒加载

-(NSMutableArray *)videoList
{
    if(!_videoList){
        _videoList = [[NSMutableArray alloc]init];
    }
    return _videoList;
}

@end
