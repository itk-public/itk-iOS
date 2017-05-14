//
//  IGURLManager.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int,IGURLHostType)
{
    IGURLHostB2CType,
    IGURLHostActivityType,
    IGURLHostH5ActType,
    IGURLHostTrackLogType
};


@class IGURLHostConfig;
@interface IGURLManager : NSObject
// b2c接口链接
+ (NSString *)urlWithPath:(NSString *)path;
+ (NSString *)securityURLWithPath:(NSString *)path;

// 自定义类型的URL链接
+ (NSString *)urlUnderHostType:(IGURLHostType)type path:(NSString *)path;

// 当前b2c host
+ (NSString *)outURLHost;
@end


@interface IGURLHostConfig : NSObject

@end

#if defined(ISDebugOptionValid)
@interface IGURLHostConfig(debug)

- (void)updateHost:(NSString *)host forType:(IGURLHostType)type;

+ (NSString *)baseHostFor:(IGURLHostType)type;

+ (instancetype)defaultConfig;

@end
#endif
