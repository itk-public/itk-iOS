//
//  SubCategoryModel.h
//  PR
//
//  Created by 黄小雪 on 2017/6/5.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "ProductOutline.h"

@interface SubCategoryModel : YHDataModel
@property (copy,nonatomic) NSString *subCategoryName;
@property (readonly,nonatomic) NSString *subCategoryId;
@property (readonly,nonatomic) NSArray<ProductOutline *> *subCategorySkus;
@end
