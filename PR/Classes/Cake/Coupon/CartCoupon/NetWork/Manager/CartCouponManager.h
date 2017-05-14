//
//  CartCouponManager.h
//  PR
//
//  Created by 黄小雪 on 20/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "BaseManager.h"

@interface CartCouponManager : BaseManager
-(void)getCartCouponsWithShopId:(NSString *)shopid;
@end
