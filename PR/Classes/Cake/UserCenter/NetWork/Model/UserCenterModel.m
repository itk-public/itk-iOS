//
//  UserCenterModel.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UserCenterModel.h"

@implementation UserInfo
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _phoneNum = [dic safeObjectForKey:@"phonenum"];
        _nickName = [dic safeObjectForKey:@"nickname"];
        _sexType  = [[dic safeObjectForKey:@"sex"]integerValue];
    }
    return self;
}
@end

@implementation AssetsInfo
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        NSInteger balanceCent = [[dic safeObjectForKey:@"balance"] integerValue];
        _balanceString = [NSString stringWithFormat:@"￥%.2f",balanceCent/100.0];
        NSInteger couponCount = [[dic safeObjectForKey:@"coupon"] integerValue];
        _couponString = [NSString stringWithFormat:@"%zd张",couponCount];
    }
    return self;
}
@end


@implementation OrderInfo
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _toDelivery = [[dic safeObjectForKey:@"todelivery"]integerValue];
        _toPick     = [[dic safeObjectForKey:@"topickup"]integerValue];
        _toComment  = [[dic safeObjectForKey:@"tocomment"]integerValue];
        _refunding  = [[dic safeObjectForKey:@"refunding"]integerValue];
    }
    return self;
}

@end

@implementation UserCenterModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _userInfo = [UserInfo modelFromDictionary:dic];
        _assetInfo = [AssetsInfo modelFromDictionary:dic];
        _orderInfo = [OrderInfo modelFromDictionary:dic];
    }
    return self;
}
@end
