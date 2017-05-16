//
//  CartShopDataBaseModel.m
//  PR
//
//  Created by 黄小雪 on 27/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartShopDataBaseModel.h"


NSString *kPidKey         = @"kPidKey";
NSString *kShopIdKey      = @"kShopIdKey";
NSString *kIsSelectedKey  = @"kIsSelectedKey";
NSString *kNumKey         = @"keynumkey";

@implementation CartShopDataBaseModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    CONDITION_CHECK_RETURN_VAULE([dic isKindOfClass:[NSDictionary class]], nil);
    if (self = [super initWithDictionary:dic]) {
         _cid        = [dic safeObjectForKey:kPidKey hintClass:[NSString class]];
        _shopId     = [dic safeObjectForKey:kShopIdKey hintClass:[NSString class]];
        _isSelected = [[dic safeObjectForKey:kIsSelectedKey hintClass:[NSNumber class]]boolValue];
        _num        = [[dic safeObjectForKey:kNumKey hintClass:[NSNumber class]]integerValue];
    }
    return self;
}

+(instancetype)modelFromDictionary:(NSDictionary *)dic
{
    return [[self alloc]initWithDictionary:dic];
}
@end
