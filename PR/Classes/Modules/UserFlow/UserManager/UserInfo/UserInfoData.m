//
//  UserInfoData.m
//  PR
//
//  Created by 黄小雪 on 08/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UserInfoData.h"

@implementation UserInfoData
IMP_SINGLETON

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithUID:(NSString *)uid token:(NSString *)token
{
    if (self = [super init]) {
        _uid = uid;
        _uToken = token;
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    if (self = [super init]) {
        _uid = [dict safeObjectForKey:@"uid" hintClass:[NSString class]];
        _uToken = [dict safeObjectForKey:@"token" hintClass:[NSString class]];
    }
    return self;
}

@end
