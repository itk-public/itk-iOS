//
//  WTPersistenceCenter.h
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KPhoneKey  @"phonekey"
#define KUIDKey    @"uidkey"
#define KEpPhoneKey  @"enterpricePhonekey" //企业用户手机号保存。区分个人用户手机，分用户类型存取，暂时影响用户                 反馈界面，如果之后影响增多。会考虑合并到一起
#define WXInfoNick @"wxNickName"
#define WXInfoImage @"infoImage"
#define WXInfoUnionId @"infoUnionId"
#define WXLogInSuccess @"LogInsuccess"
FOUNDATION_EXTERN NSString *const KContactTel;
FOUNDATION_EXPORT NSString *const KContactName;

typedef NS_ENUM(NSInteger,PersistenceType)
{
    PersistenceUserDefault,
    PersistenceLocal,
    PersistenceKeyChain,
};


@interface WTPersistenceCenter : NSObject
#pragma mark ----------------------常用公共存储
/**
 *	保存常用信息到userDefault
 *	支持精简信息，例如版本号、用户偏好开关等。尽支持可序列化对象
 */
+ (void)storeInfo:(id )info key:(NSString *)key type:(PersistenceType)type;

/**
 *	移除userDefault中不用的信息
 */
+ (void)removeInfo:(NSString *)key type:(PersistenceType)type;

/**
 *	从userDefault中获取信息
 */
+ (id)getInfo:(NSString *)key type:(PersistenceType)type;

#pragma mark ----------------------lua管理区域
/**
 * 获取本地lua版本信息
 */
+ (NSString*)getLuaVersion;

/**
 * 设置本地lua版本信息
 */
+ (void)setLuaVersion:(NSString*)lv;

@end
