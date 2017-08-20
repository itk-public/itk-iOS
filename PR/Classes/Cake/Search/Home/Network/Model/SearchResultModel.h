//
//  SearchResultModel.h
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "ProductOutline.h"
#import "SearchShopDescInfo.h"

@interface SearchResultModel : YHDataModel
@property (readonly,nonatomic) NSArray<ProductOutline *> *products;
@property (readonly,nonatomic) SearchShopDescInfo        *shopInfo;
//搜索到的相关商品总数
@property (readonly,nonatomic) NSInteger totalNum;
@end
