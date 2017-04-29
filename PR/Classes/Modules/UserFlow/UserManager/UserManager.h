//
//  UserManager.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDetailInfo.h"
#import "UserInfoData.h"

FOUNDATION_EXTERN NSString *const UserManagerLoginNotification;
FOUNDATION_EXTERN NSString *const UserMananegrDidLogoutNotification;

@interface UserManager : NSObject
{
    @protected
    UserDetailInfo *loginUserData;
    
}

DEF_SINGLETON(UserManager)
+(id)shareMananger;

/**
 *  用户是否登录
 *
 *  @return 判断用户是否登录
 */
- (BOOL)isUserLogin;

/**
 *  获取当前用户的用户信息
 */
-(UserInfoData *)userData;

@end
