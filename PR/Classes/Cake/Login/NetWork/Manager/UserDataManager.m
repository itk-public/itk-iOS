//
//  UserDataManager.m
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "UserDataManager.h"
#import "PhoneQuickLoginAPIInteract.h"
#import "AccoutLoginAPIInteract.h"
#import "SecurityCodeAPIInteract.h"
#import "RegisterAPIInteract.h"
#import "ForgetPwdAPIInteract.h"
#import "UserCenterAPIInteract.h"


@interface UserDataManager()
@property (strong,nonatomic) PhoneQuickLoginAPIInteract *phoneQuickAPI;
@property (strong,nonatomic) AccoutLoginAPIInteract     *accoutLoginAPI;
@property (strong,nonatomic) SecurityCodeAPIInteract    *securityCodeAPI;
@property (strong,nonatomic) RegisterAPIInteract        *registerAPI;
@property (strong,nonatomic) ForgetPwdAPIInteract       *forgetPwdAPI;
@property (strong,nonatomic) UserCenterAPIInteract      *userCenterAPI;

@end
@implementation UserDataManager
-(BOOL)loginWithPhoneNum:(NSString *)phoneNum safetyCode:(NSString *)safetyCode
{
    if (self.phoneQuickAPI == nil) {
         self.phoneQuickAPI =  [[PhoneQuickLoginAPIInteract alloc]init];
    }
    [self.phoneQuickAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:UserDataManangerTypePhoneQuickLogin data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:UserDataManangerTypePhoneQuickLogin error:error];
        }
    }];
    
    return YES;
}

-(void)loginWithAccout:(NSString *)phoneNum pwd:(NSString *)pwd
{
    if (self.accoutLoginAPI == nil) {
         self.accoutLoginAPI =  [[AccoutLoginAPIInteract alloc]init];
    }
    [self.accoutLoginAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:UserDataManangerTypeAccoutLogin data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:UserDataManangerTypeAccoutLogin error:error];
        }
    }];
}

-(void)securityCodeWithPhoneNum:(NSString *)phoneNum
{
    if (self.securityCodeAPI == nil) {
        self.securityCodeAPI = [[SecurityCodeAPIInteract alloc]init];
    }
    [self.securityCodeAPI  interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:UserDataManangerTypeSafetyCode data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:UserDataManangerTypeSafetyCode error:error];
        }
    }];
}

-(void)registerWithPhoneNum:(NSString *)phoneNum safetyCode:(NSString *)safetyCode pwd:(NSString *)pwd
{
    if (self.registerAPI == nil) {
        self.registerAPI = [[RegisterAPIInteract alloc]init];
    }
    [self.registerAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:UserDataManangerTypeRegister data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:UserDataManangerTypeRegister error:error];
        }
    }];
}

-(void)forgetPwdWithPhoneNum:(NSString *)phoneNum safetyCode:(NSString *)safetyCode pwd:(NSString *)pwd
{
    if (self.forgetPwdAPI == nil) {
        self.forgetPwdAPI = [[ForgetPwdAPIInteract alloc]init];
    }
    [self.forgetPwdAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:UserDataManangerTypeForgetPwd data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:UserDataManangerTypeForgetPwd error:error];
        }
    }];
}
-(void)getCenterInfo
{
    if (self.userCenterAPI == nil) {
        self.userCenterAPI = [[UserCenterAPIInteract alloc]init];
    }
    [self.userCenterAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:UserDataManangerTypeCenterInfo data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:UserDataManangerTypeCenterInfo error:error];
        }
    }];
}
@end
