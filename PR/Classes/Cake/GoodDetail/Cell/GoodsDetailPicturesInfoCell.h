//
//  GoodsDetailPicturesInfoCell.h
//  PR
//
//  Created by 黄小雪 on 2017/6/6.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"

@interface GoodsDetailPicturesInfoModel : YHDataModel
@property (copy,nonatomic) NSArray *pictureDetailUrlArr;
@property (copy,nonatomic) NSDictionary *pictureDetailImgDic;
@end

@interface GoodsDetailPicturesInfoCell : WTTableViewCell

@end
