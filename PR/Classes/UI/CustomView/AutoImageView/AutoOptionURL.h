//
//  AutoOptionUR.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,AutoOptionPriority)
{
    AOP_NetworkEnvir,
    AOP_LowFlow,
    AOP_HightExperience,
};

@interface AutoOptionURL : NSObject

@property(nonatomic,assign)AutoOptionPriority  aop;
@property(nonatomic,readonly)NSURL *  urlUponWifi;
@property(nonatomic,readonly)NSURL *  urlUponWWAN;

/**
 *  类方法构建一个包含了 wifi 下以及wwan 下得 auto option url
 *
 *  @param urlWifi wifi 下使用的 url
 *  @param urlWWAN  移动网络下使用的 url
 *
 *  @return 一个包含指定数据的 AutoOptionURL 对象
 */
+ (AutoOptionURL *)optionURLWithImageURL:(NSString *)imgURL;
+ (AutoOptionURL *)optionUrlInWifi:(NSString *)urlWifiStr andInWWAN:(NSString *)urlWWANStr;

- (NSURL *)autoSelectedURL;
@end
