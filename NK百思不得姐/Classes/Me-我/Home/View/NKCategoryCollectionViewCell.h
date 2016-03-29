//
//  NKCategoryCollectionViewCell.h
//  NKVideoPlayer
//
//  Created by 陆金龙 on 16/2/18.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *CellID = @"UICollectionViewCell";
@class Categorie;
@interface NKCategoryCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) Categorie *categorie;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView ItemAtIndexPath:(NSIndexPath *)indexPath;
@end
