//
//  CartCoupons.h
//  PR
//
//  Created by 黄小雪 on 20/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "ShopDescInfo.h"

@interface CartCoupons : YHDataModel
@property (readonly,nonatomic) NSArray       *coupons;
@property (readonly,nonatomic) ShopDescInfo  *shopInfo;
@end
