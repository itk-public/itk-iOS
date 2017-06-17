//
//  ShopHomeDetailInfo.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeDetailInfo.h"

@implementation ShopHomeDetailInfo
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _shopInfo = [ShopHomeShopInfo modelFromDictionary:dic];
        NSArray *tempCoupons = [dic safeObjectForKey:@"coupons" hintClass:[NSArray class]];
        if (tempCoupons && [tempCoupons count]) {
            NSMutableArray *temp = [NSMutableArray arrayWithCapacity:[tempCoupons count]];
            for (NSDictionary *tempDict in tempCoupons) {
                [temp safeAddObject:[CouponModel modelFromDictionary:tempDict]];
            }
            _coupons = [NSArray arrayWithArray:temp];
            temp = nil;
        }
        NSArray *tempProducts = [dic safeObjectForKey:@"products" hintClass:[NSArray class]];
        if (tempProducts && [tempProducts count]) {
            NSMutableArray *temp = [NSMutableArray arrayWithCapacity:[tempProducts count]];
            for (NSDictionary *tempDict in tempProducts) {
                [temp safeAddObject:[ProductOutline modelFromDictionary:tempDict]];
            }
            _products = [NSArray arrayWithArray:temp];
            temp = nil;
        }
    }
    return self;
}
@end
