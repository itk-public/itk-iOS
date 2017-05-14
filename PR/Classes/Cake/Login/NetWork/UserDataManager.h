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
@end

