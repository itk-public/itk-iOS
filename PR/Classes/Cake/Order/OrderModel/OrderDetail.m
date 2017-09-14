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
        
        NSArray *appointments = [dic safeObjectForKey:@"appointments" hintClass:[NSArray class]];
        if (appointments) {
            _deliveryTimeInfo     = [ODDeliveryTimeInfo dealAppointmentsTime:appointments];
        }else{
            NSDictionary * exception = [dic safeObjectForKey:@"expecttime" hintClass:[NSDictionary class]];
            _deliveryTimeInfo = [ODDeliveryTimeInfo dealExceptionTimeDict:exception];
        }
        
        _coupon = [CouponModel modelFromDictionary:[dic safeObjectForKey:@"coupon"]];
        _freeShipping = [dic safeObjectForKey:@"freeShipping"];
        
        NSInteger priceTotalCent = [[dic safeObjectForKey:@"priceTotal"]integerValue];
        _priceTotal = [NSString stringWithFormat:@"总计：￥%.2f元",priceTotalCent/100.0];
        
        NSInteger totalPaymentCent = [[dic safeObjectForKey:@"totalPayment"]integerValue];
        _totalPayment = [NSString stringWithFormat:@"总计：%.2f元",totalPaymentCent/100.0];
        _totalPaymentCent = totalPaymentCent;
        
        NSInteger freightCent = [[dic safeObjectForKey:@"freight"]integerValue];
        _freight = [NSString stringWithFormat:@"运费：%zd元",freightCent/100];
        
        NSInteger discountCent = [[dic safeObjectForKey:@"discount"]integerValue];
        _discount = [NSString stringWithFormat:@"合计：%.2f",discountCent/100.0];
        

        
        
    }
    return self;
}
@end
