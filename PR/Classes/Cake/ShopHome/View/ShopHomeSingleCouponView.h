//
//  ShopHomeSingleCouponView.h
//  PR
//
//  Created by 黄小雪 on 2017/6/10.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"

#define kShopHomeSingleCouponViewW  170
@interface ShopHomeSingleCouponView : UIView
@property (strong,nonatomic) CouponModel *coupon;
+(CGFloat)height;
@end
