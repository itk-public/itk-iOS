//
//  UserManager.m
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UserManager.h"
#import "UserDetailInfo.h"


NSString *const UserManagerLoginNotification      = @"userlogin";
NSString *const UserMananegrDidLogoutNotification = @"userlogout";

@interface UserManager()
@property (strong,nonatomic)UserDetailInfo *loginUserData;

@end
@implementation UserManager
IMP_SINGLETON

+(id)shareMananger
{
    return [[self alloc]init];
}

-(BOOL)isUserLogin
{
    return self.loginUserData.userId.length && self.loginUserData.userToken.length;
}

-(UserInfoData *)userData
{
    return [self.loginUserData publicInfo];
}
-(void)saveUserInfo:(NSDictionary *)dict;
{
    NSString *uid = [dict safeObjectForKey:@"uid"];
    NSString *uToken = [dict safeObjectForKey:@"accesstoken"];
    self.loginUserData.userId = uid;
    self.loginUserData.userToken = uToken;
    [self.loginUserData saveToLocal];
    if ([uid length]) {
         [[NSNotificationCenter defaultCenter] postNotificationName:UserManagerLoginNotification object:nil];
    }
}

-(UserDetailInfo *)loginUserData
{
    if (_loginUserData == nil) {
        _loginUserData = [UserDetailInfo newUserFromLocal];
    }
    return _loginUserData;
}
@end
