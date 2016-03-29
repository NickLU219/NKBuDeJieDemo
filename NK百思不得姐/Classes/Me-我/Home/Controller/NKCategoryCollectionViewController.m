//
//  NKCategoryCollectionViewController.m
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NKCategoryCollectionViewController.h"
#import "Categorie.h"
#import "MBProgressHUD+BM.h"
#import "MJExtension.h"
#import "NKCategoriesTimeViewController.h"
#import "NKCategoryCollectionViewCell.h"
#import "NKCatgoriesTimeAndShareViewController.h"
#import "NKHttpTool.h"

@interface NKCategoryCollectionViewController ()
@property (nonatomic ,strong) NSArray *categories;
@end

@implementation NKCategoryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];


    // 加载数据
    [self addViewData];

    // 注册cell
    [self.collectionView registerClass:[NKCategoryCollectionViewCell class] forCellWithReuseIdentifier:CellID];

    [self.collectionView setBackgroundColor:[UIColor whiteColor]];

    self.collectionView.backgroundColor = NKColorWithAlpha(240, 240, 240, 0.9);
}


/**
 *  初始化
 */
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [self settingLayout];
    if (self = [super initWithCollectionViewLayout:layout]) {
        [self addNavigationItem];

    }
    return self;
}

/**
 *  加载数据
 */
- (void)addViewData
{
    [NKHttpTool GET:[Categorie toPath] parameters:[Categorie toParameter] success:^(id json) {
        // 保存数据
        _categories = [Categorie mj_objectArrayWithKeyValuesArray:json];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        // 提示网络故障
        [MBProgressHUD showError:@"网络故障"];
    }];
}

#pragma mark 设置布局
- (UICollectionViewFlowLayout *)settingLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置间距
    CGFloat spacing = 3;
    layout.minimumLineSpacing = spacing;
    layout.minimumInteritemSpacing = spacing;
    layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, 0, spacing); // 上部内边距

    // 设置Item的Size
    CGFloat ItemW = (ScreenSize.width - spacing) / 2 - spacing;
    CGFloat ItemH = ItemW;
    layout.itemSize = CGSizeMake(ItemW, ItemH);

    return layout;

}

#pragma mark 设置Nav
/**
 *  设置Nav
 */
- (void)addNavigationItem
{
    //设置标题
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    attributes[NSFontAttributeName] = Font_EnglishFont(20);
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"NickLU" attributes:attributes];
    UILabel *titleView = [[UILabel alloc]init];
    titleView.attributedText = title;
    [titleView setBounds:CGRectMake(0, 0, title.size.width, title.size.height)];
    self.navigationItem.titleView = titleView;

    //设置右边按钮
    UIButton *changeButton = [[UIButton alloc] init];
    //    changeButton.backgroundColor = [UIColor redColor];
    [changeButton setTitle:@"每日精选" forState:UIControlStateNormal];
    changeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeButton sizeToFit];
    [changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *changeItem =[[UIBarButtonItem alloc] initWithCustomView:changeButton];
    self.navigationItem.rightBarButtonItem = changeItem;

}

- (void)change {
    self.tabBarController.selectedIndex = 0;
}
#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.categories.count;
}



//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    NKCategoryCollectionViewCell *cell = [NKCategoryCollectionViewCell cellWithCollectionView:collectionView ItemAtIndexPath:indexPath];

    Categorie *categorie = self.categories[indexPath.row];
    // 传输数据
    cell.categorie = categorie;

    return cell;
}
#pragma mark -- UICollectionView代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NKCatgoriesTimeAndShareViewController *vc = [[NKCatgoriesTimeAndShareViewController alloc]init];
    vc.categorie = self.categories[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];



}
#pragma mark -- 懒加载
-(NSArray *)categories
{
    if(!_categories){
        self.categories = [[NSArray alloc]init];
    }
    return _categories;
}

@end
