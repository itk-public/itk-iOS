//
//  OrderDetail.m
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderDetail.h"

@implementation OrderDetail
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _cid = [dic safeObjectForKey:@"id"];
        _orderType = [[dic safeObjectForKey:@"deliverymode"]integerValue];
        _orderStauts = [[dic safeObjectForKey:@"status"]integerValue];
        _title = [dic safeObjectForKey:@"title"];
        NSDictionary *timeInfoDic = [dic safeObjectForKey:@"timeinfo" hintClass:[NSDictionary class]];
        if (timeInfoDic) {
            _timeInfo = [OrderTimeInfo modelFromDictionary:timeInfoDic];
        }
        _pickSelfCode = [dic safeObjectForKey:@"pickSelfCode"];
        NSArray *tempProducts = [dic safeObjectForKey:@"products" hintClass:[NSArray class]];
        if (tempProducts) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for(NSDictionary *dict in tempProducts){
                ProductOutline *product = [ProductOutline modelFromDictionary:dict];
                [tempArray addObject:product];
            }
            _proudcts = [NSArray arrayWithArray:tempArray];
        }
        
        NSString *actionStr = [dic safeObjectForKey:@"action"];
        if (actionStr && [actionStr length]) {
            _action = [Action actionWithString:actionStr];
        }
        
        _isRefundable = [[dic safeObjectForKey:@"refundable"]boolValue];
        
        NSDictionary *shopInfoDict = [dic safeObjectForKey:@"shop" hintClass:[NSDictionary class]];
        if (shopInfoDict) {
            _shopInfo = [ShopDescInfo modelFromDictionary:shopInfoDict];
        }
       
        _priceDetail = [[OrderPriceDetail alloc]init];
        [_priceDetail updatePriceInfo:dic];
    }
    return self;
}
@end
