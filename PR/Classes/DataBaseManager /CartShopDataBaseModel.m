//
//  CartShopDataBaseModel.m
//  PR
//
//  Created by 黄小雪 on 27/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartShopDataBaseModel.h"

NSString *kPidKey         = @"kpidkey";
NSString *kSelleridKey    = @"kselleridkey";
NSString *kSelectstateKey = @"kselectstatekey";
NSString *kNumKey         = @"keynumkey";

@implementation CartShopDataBaseModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    CONDITION_CHECK_RETURN_VAULE([dic isKindOfClass:[NSDictionary class]], nil);
    if (self = [super initWithDictionary:dic]) {
         _pid = [dic safeObjectForKey:kPidKey
                            hintClass:[NSString class]];
        _sellerid    = [dic safeObjectForKey:kSelleridKey
                                   hintClass:[NSString class]];
        _selectstate = [[dic safeObjectForKey:kSelectstateKey
                                    hintClass:[NSNumber class]]boolValue];
        _num         = [[dic safeObjectForKey:kNumKey
                                    hintClass:[NSNumber class]]integerValue];
      
    }
    return self;
}

+(instancetype)modelFromDictionary:(NSDictionary *)dic
{
    return [[self alloc]initWithDictionary:dic];
}
@end
