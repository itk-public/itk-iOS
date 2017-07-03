//
//  OrderPriceDetail.m
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderPriceDetail.h"

@implementation OrderPriceDetail
- (void)updatePriceInfo:(NSDictionary *)dict
{
    _totalAmount = [[dict safeObjectForKey:@"totalPayment"]integerValue];
}

- (NSString *)totalPriceDes
{
    return [NSString stringWithFormat:@"￥%.2f",self.totalAmount / 100.0];
}

@end
