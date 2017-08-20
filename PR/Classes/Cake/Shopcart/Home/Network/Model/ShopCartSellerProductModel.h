//
//  CartProudctWithOtherInfoModel.h
//  YHClouds
//
//  Created by 黄小雪 on 15/10/27.
//  Copyright © 2015年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartOtherInfoModel.h"
#import "ShopDescInfo.h"
#import "CartOrderCellViewModel.h"

@interface ShopCartSellerProductModel : NSObject

@property (nonatomic,strong)   CartOtherInfoModel *infoModel;//价格信息
@property (nonatomic,readonly) NSMutableArray    *productArr;//产品数组
@property (strong,nonatomic)  ShopDescInfo       *sellerInfo;//商家信息
@property (assign,nonatomic)   BOOL               isEdit;//是否编辑


+ (instancetype)cartProudctWithOtherInfoModelWithDict:(NSDictionary *)dict;


@end
