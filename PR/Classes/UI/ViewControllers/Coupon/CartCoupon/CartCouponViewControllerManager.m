//
//  CartCouponViewControllerManager.m
//  PR
//
//  Created by 黄小雪 on 20/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartCouponViewControllerManager.h"
#import "CartCouponManager.h"
#import "CouponsSelectView.h"
#import "CartCoupons.h"

@interface CartCouponViewControllerManager()<ManagerDelegate>
@property (strong,nonatomic) CartCouponManager *manager;
@property (strong,nonatomic) CouponsSelectView *couponsView;
@end

@implementation CartCouponViewControllerManager
-(void)getCartCouponsWithShopId:(NSString *)shopid
{
    if (self.manager == nil) {
        self.manager = [[CartCouponManager alloc]init];
        self.manager.delegate = self;
    }
    [self.manager getCartCouponsWithShopId:nil];
}

- (void)requestSuccess:(id)modelData isCache:(BOOL)isCache
{
    CONDITION_CHECK_RETURN([modelData isKindOfClass:[CartCoupons class]]);
    if (self.couponsView == nil) {
        self.couponsView  = [CouponsSelectView defaultCouponsSelectView];
    }
    [self.couponsView setCartCoupons:modelData];
    [self.couponsView show];
}
- (void)requestFailed:(NSError *)error
{
    
}
@end
