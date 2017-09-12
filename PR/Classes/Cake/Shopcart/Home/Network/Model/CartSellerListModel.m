//
//  CartSellerListModel.m
//  YHClouds
//
//  Created by 黄小雪 on 16/7/28.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartSellerListModel.h"
#import "CartDataHandle.h"
#import "ShopCartSellerProductModel.h"


@implementation CartSellerListModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    CONDITION_CHECK_RETURN_VAULE([dic isKindOfClass:[NSDictionary class]], nil);
    if (self = [super initWithDictionary:dic]) {
        NSDictionary *data             = [dic safeObjectForKey:@"cartList" hintClass:[NSDictionary class]];
        ShopCartSellerProductModel  *sellerProduct = [ShopCartSellerProductModel  cartProudctWithOtherInfoModelWithDict:data];
        _sellerArray = @[sellerProduct];
    }
    return self;
}


+(instancetype)modelFromDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDictionary:dic];
}


@end
