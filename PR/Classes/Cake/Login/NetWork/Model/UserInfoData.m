//
//  UserInfoData.m
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "UserInfoData.h"

@implementation UserInfoData
-(instancetype)initWithUID:(NSString *)uid token:(NSString *)token
{
    CONDITION_CHECK_RETURN_VAULE([uid length] && [token length], nil);
    if (self = [super init]) {
        _uid = uid;
        _uToken = token;
    }
    return self;
}
@end
