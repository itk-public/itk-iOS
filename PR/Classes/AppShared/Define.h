//
//  Define.h
//  PR
//
//  Created by 黄小雪 on 06/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef Define_h
#define Define_h

/******************************		system & device 宏定义	***************************************/
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[Utilities curOSVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)		([[Utilities curOSVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define SYSTEM_VERSION_LESS_THAN(v)		([[Utilities curOSVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define iOS10 ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0 ? YES : NO)
#define iOS9 ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0 ? YES : NO)
#define iOS8 ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0 ? YES : NO)    // iOS8(包含)以上的系统判断
#define iOS7 ([[UIDevice currentDevice] systemVersion].floatValue = 7.0 ? YES : NO)     //IOS7


#define iPhone4     (CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size))
#define iPhone5     (CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size))
#define iPhone6     (CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size))
#define iPhone6p    (CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size))
#define isNarrowScreem  (iPhone4||iPhone5)
#define is2XScreem  (iPhone4||iPhone5||iPhone6)


/******************************		定义关键的全局notification	***************************************/
#define AppKeyNotifyBecomeActive            @"yhapBecomeAction"
#define AppKeyNotifyEnterForeground         @"yhapEnterFore"
#define AppKeyNotifyResignActive            @"yhapResignActive"
#define AppKeyNotifyEnterBackground         @"yhapEnterBack"

#define KEY_NOTIFICATION_WEBVIEW_CONTENT    @"KEY_NOTIFICATION_WEBVIEW_CONTENT"
#define KEY_NOTIFICATION_CART_AMOUNT_CHANGE @"KEY_NOTIFICATION_CART_AMOUNT_CHANGE"

#define DISMISS_LOGIN_REGISTER_FORGETPWD    @"loginSuccess"

/******************************	 定义全局存储key 	***************************************/
#define AppStore_LatestLostFoucse_Key       @"AppLatestLostFoucse"

/******************************	 定义全局宏值 	***************************************/

//#if defined(DEBUG) || FEATURE_APP_CHANNEL == FEATURE_APP_CHANNEL_ADHOC || defined(kAutoToTestInEnvir)
//#define  ISDebugOptionValid
//#else
//#undef   ISDebugOptionValid
//#endif



#endif /* Define_h */
