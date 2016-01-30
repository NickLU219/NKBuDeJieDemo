//
//  NKConst.h
//  NK百思不得姐
//
//  Created by 陆金龙 on 16/1/26.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    NKTopicTypeAll = 1,
    NKTopicTypePicture = 10,
    NKTopicTypeWord = 29,
    NKTopicTypeVoice = 31,
    NKTopicTypeVideo = 41
} NKTopicType;


/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const NKTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const NKTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const NKTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const NKTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const NKTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const NKTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const NKTopicCellPictureBreakH;


/** XMGUser模型-性别属性值 */
UIKIT_EXTERN NSString * const NKUserSexMale;
UIKIT_EXTERN NSString * const NKUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const NKTopicCellTopCmtTitleH;





