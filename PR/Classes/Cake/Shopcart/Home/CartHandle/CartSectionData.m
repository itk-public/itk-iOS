//
//  CartSectionData.m
//  YHClouds
//
//  Created by 黄小雪 on 16/8/15.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartSectionData.h"

@implementation CartSectionData

-(void)setSellerProducts:(ShopCartSellerProductModel *)sellerProducts
{
    CONDITION_CHECK_RETURN([sellerProducts isKindOfClass:[ShopCartSellerProductModel class]]);
    _sellerProductModel = sellerProducts;
    if (_dataHandle == nil) {
        _dataHandle = [[CartDataHandle alloc]init];
    }
    [_dataHandle setSellerProduct:sellerProducts editType:self.editType];
    _sortedSellerProducts = [_dataHandle sortedSellerProducts];
}

@end
