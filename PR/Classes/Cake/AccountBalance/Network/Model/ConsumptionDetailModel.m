//
//  ConsumptionDetailModel.m
//  PR
//
//  Created by 黄小雪 on 2017/9/13.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ConsumptionDetailModel.h"

@implementation ConsumptionDetailModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _type = [[dic safeObjectForKey:@"cousumptionType"]integerValue];
        _dateStr = [dic safeObjectForKey:@"cousumptionDate"];
        long amount = [[dic safeObjectForKey:@"amount"]longValue];
        if (_type == ConsumptionDetailModelTypeConsumption) {
            _moneyStr = [NSString stringWithFormat:@"-%.2f",amount/100.0];
        }else if (_type == ConsumptionDetailModelTypeRefund){
            _moneyStr = [NSString stringWithFormat:@"+%.2f",amount/100.0];
        }
    }
    return self;
}
@end
