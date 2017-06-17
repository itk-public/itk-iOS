//
//  ShopHomeDetailInfo.h
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "ShopHomeShopInfo.h"
#import "CouponModel.h"
#import "ProductOutline.h"

@interface ShopHomeDetailInfo : YHDataModel
@property (readonly,nonatomic) ShopHomeShopInfo          *shopInfo;
@property (readonly,nonatomic) NSArray<CouponModel *>    *coupons;
@property (readonly,nonatomic) NSArray<ProductOutline *> *products;
@end
