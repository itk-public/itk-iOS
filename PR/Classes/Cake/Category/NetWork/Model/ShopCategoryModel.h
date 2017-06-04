//
//  ShopCategoryModel.h
//  PR
//
//  Created by 黄小雪 on 2017/6/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@interface ShopCategoryModel : YHDataModel
@property (readonly,nonatomic) NSString *categoryId;
@property (readonly,nonatomic) NSString *categoryName;
@end
