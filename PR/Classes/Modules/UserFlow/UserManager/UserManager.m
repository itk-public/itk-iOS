//
//  UserManager.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UserManager.h"

NSString *const UserManagerLoginNotification      = @"userlogin";
NSString *const UserMananegrDidLogoutNotification = @"userlogout";

@implementation UserManager
IMP_SINGLETON

+(id)shareMananger
{
    return [[self alloc]init];
}

-(BOOL)isUserLogin
{
    return loginUserData.userId.length && loginUserData.userToken.length;
}

-(UserInfoData *)userData
{
    return [loginUserData publicInfo];
}
@end
