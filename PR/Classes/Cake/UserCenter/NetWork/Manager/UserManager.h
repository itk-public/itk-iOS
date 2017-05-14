//
//  UserManager.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoData.h"

FOUNDATION_EXTERN NSString *const UserManagerLoginNotification;
FOUNDATION_EXTERN NSString *const UserMananegrDidLogoutNotification;

@interface UserManager : NSObject

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

/**
 *  限制级别的接口，这里面的接口都是高危型的。
 *  这里的借口请确认后调用
 */
@interface UserManager(RestrictedInterface)
-(void)saveUserInfo:(NSDictionary *)dict;
@end
