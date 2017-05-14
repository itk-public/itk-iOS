//
//  CartCouponManager.m
//  PR
//
//  Created by 黄小雪 on 20/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartCouponManager.h"
#import "CartCouponAPIInteract.h"

@interface CartCouponManager()
@property (strong,nonatomic) CartCouponAPIInteract *couponApI;

@end
@implementation CartCouponManager
-(void)getCartCouponsWithShopId:(NSString *)shopid
{
    if (self.couponApI == nil) {
         self.couponApI = [[CartCouponAPIInteract alloc]init];
    }
    [self.couponApI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestSuccess:isCache:)]) {
            [self.delegate requestSuccess:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:error];
        }
    }];
}
@end
