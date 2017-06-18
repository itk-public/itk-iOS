//
//  ShopHomeCarouselView.m
//  PR
//
//  Created by 黄小雪 on 2017/6/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeCarouselView.h"
#import "ShopHomeSingleCouponView.h"

@implementation ShopHomeCarouselView
-(instancetype)init
{
    if (self = [super init]) {
        self.singleViewW = kShopHomeSingleCouponViewW;
        self.carouselSingleViewClass = [ShopHomeSingleCouponView class];
    }
    return self;
}
@end
