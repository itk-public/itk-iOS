//
//  UserDataManager.h
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserDataManager;

typedef NS_ENUM(NSInteger,UserDataManangerType)
{
    
    UserDataManangerTypePhoneQuickLogin,     //手机快捷登录
    UserDataManangerTypeAccoutLogin,         //用户名密码登录
    UserDataManangerTypeSafetyCode,          //获取验证码
    UserDataManangerTypeRegister,            //注册
    UserDataManangerTypeForgetPwd,           //忘记密码
    UserDataManangerTypeCenterInfo,          //个人中心
    
};


@protocol UserDataManagerDelegate <NSObject>
@required

-(void)loadDataSuccessful:(UserDataManager *)manager dataType:(UserDataManangerType)dataType  data:(id)data  isCache:(BOOL)isCache;
-(void)loadDataFailed:(UserDataManager *)manager dataType:(UserDataManangerType)dataType error:(NSError*)error;

@end

@interface UserDataManager : NSObject
@property (weak,nonatomic) id<UserDataManagerDelegate> delegate;

//手机快捷登录，phoneNum:手机号码，safetyCode验证码
-(BOOL)loginWithPhoneNum:(NSString *)phoneNum safetyCode:(NSString *)safetyCode;
//用户名密码登录
-(void)loginWithAccout:(NSString *)phoneNum pwd:(NSString *)pwd;
//获取验证码
-(void)securityCodeWithPhoneNum:(NSString *)phoneNum;
//注册
-(void)registerWithPhoneNum:(NSString *)phoneNum safetyCode:(NSString *)safetyCode pwd:(NSString *)pwd;
//忘记密码
-(void)forgetPwdWithPhoneNum:(NSString *)phoneNum safetyCode:(NSString *)safetyCode pwd:(NSString *)pwd;
//获取个人中心
-(void)getCenterInfo;
@end

