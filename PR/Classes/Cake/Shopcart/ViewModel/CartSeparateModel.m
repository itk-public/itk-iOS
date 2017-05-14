//
//  CartSeparateModel.m
//  YHClouds
//
//  Created by 黄小雪 on 16/9/8.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartSeparateModel.h"

@implementation CartSeparateModel
-(instancetype)init{
    if (self = [super init]) {
       _prompt = @"无法配送到该收货地址";
    }
    return self;
}

-(void)setType:(PTDeliveryType)type{
    _type    = type;
    if (type == PTDeliveryFast) {
        _title = @"当日达商品";
    }else if (type == PTDeliverySlow){
        _title = @"次日次商品";
    }
}
@end
