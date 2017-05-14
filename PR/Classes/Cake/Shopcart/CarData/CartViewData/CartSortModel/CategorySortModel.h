//
//  CategorySortModel.h
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  类别排序model （包含大类 到家分类：当日达、次日达）

#import <Foundation/Foundation.h>
#import "CartModelDefine.h"

@interface CategorySortModel : NSObject

@property (nonatomic,assign)PTDeliveryType deliveryType;//配送方式
@property (nonatomic,strong)NSArray *shelvesSortArray;//该配送方式下上架、无货、下架的排序model

+ (instancetype)initWithArray:(NSArray *)array;



@end
