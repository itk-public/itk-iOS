//
//  CartCoupons.m
//  PR
//
//  Created by 黄小雪 on 20/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartCoupons.h"
#import "CouponModel.h"

@implementation CartCoupons
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        NSDictionary *shopDict = [dic safeObjectForKey:@"shop" hintClass:[NSDictionary class]];
        if (shopDict) {
            _shopInfo = [ShopDescInfo modelFromDictionary:shopDict];
        }
        
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *tempcoupons = [dic safeObjectForKey:@"coupons" hintClass:[NSArray class]];
        for (NSDictionary *dict in tempcoupons) {
            CouponModel *coupon = [CouponModel modelFromDictionary:dict];
            if (_shopInfo) {
                [coupon updateShopId:_shopInfo.cid];
            }
            [tempArray safeAddObject:coupon];
        }
        _coupons = [NSArray arrayWithArray:tempArray];
    }
    return self;
}
@end
