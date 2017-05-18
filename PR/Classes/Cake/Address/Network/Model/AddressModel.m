//
//  AddressModel.m
//  PR
//
//  Created by 黄小雪 on 2017/5/16.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "AddressModel.h"
@implementation AddressDetailModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _cityId = [dic safeObjectForKey:@"cityid"];
        _areaId = [dic safeObjectForKey:@"areaid"];
        _townId = [dic safeObjectForKey:@"townid"];
        _town   = [dic safeObjectForKey:@"town"];
        _area   = [dic safeObjectForKey:@"area"];
        _city   = [dic safeObjectForKey:@"city"];
        _detail = [dic safeObjectForKey:@"detail"];
    }
    return self;
}

-(NSString *)addressDesc
{
    return [NSString stringWithFormat:@"%@%@%@%@",self.city?:@"",self.area?:@"",self.town?:@"",self.detail?:@""];
}
@end

@implementation AddressModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _address = [AddressDetailModel modelFromDictionary: [dic safeObjectForKey:@"address"]];
        _cid    = [dic safeObjectForKey:@"id"];
        _name   = [dic safeObjectForKey:@"name"];
        _phone  = [dic safeObjectForKey:@"phone"];
    }
    return self;
}
@end
