//
//  IGURLManager.m
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "IGURLManager.h"
#import "IGURL.h"
#import "BaseRequest.h"
#import "IGHttpTask.h"
#import "PRSingleton.h"
#import "ErrorProtectCateGory.h"
#import "DebugConfigManager.h"

NSString * IGURLDefaultScheme = @"http";
NSString * IGSECURITYScheme = @"https";
NSString * IGURLHostName  =  @"api.yonghuivip.com";


@interface IGURLHostConfig()
@property(nonatomic,strong) NSDictionary * baseURLConfig;
@property(nonatomic,strong) NSMutableDictionary * mutableURLConfig;

- (NSString *)hostForType:(IGURLHostType)type;
@end


@implementation IGURLHostConfig

- (NSString *)hostForType:(IGURLHostType)type
{
    NSDictionary * useConfig = self.baseURLConfig;
#ifdef ISDebugOptionValid
    if ([DebugConfigManager isDebugOpen] && self.mutableURLConfig) {
        useConfig = self.mutableURLConfig;
    }
#endif
    NSString * hostStr =  [useConfig objectForKey:[NSNumber numberWithInt:type]];
    NSAssert(hostStr != nil, @"不应该出现不存在类型的HOST TYPE");
    return hostStr;
}

- (NSString *)schemeForType:(IGURLHostType)type
{
#ifdef ISDebugOptionValid
    if ([DebugConfigManager isDebugOpen] && [[DebugConfigManager valueForDid:@"net_https"]  integerValue] == YES) {
        return IGURLDefaultScheme;
    }
#endif
    return IGSECURITYScheme;
}

#pragma mark - init
- (instancetype)init
{
    if (self = [super init]) {
        self.baseURLConfig = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"api.yonghuivip.com",[NSNumber numberWithInt:IGURLHostB2CType],
                              @"activity.yonghuivip.com",[NSNumber numberWithInt:IGURLHostActivityType],
                              @"appactivity.yonghuivip.com",[NSNumber numberWithInt:IGURLHostH5ActType],
                              @"log.yonghuivip.com",[NSNumber numberWithInt:IGURLHostTrackLogType],
                              nil];
    }
    return self;
}

@end

/******************************************************************************
 *
 *              URL 路径管理
 *
 ******************************************************************************/
@interface IGURLManager()<IGHttpTaskTaskDelegate>
@property(nonatomic,strong)IGURLHostConfig * urlConfig;
@end

@implementation IGURLManager

IMP_SINGLETON

+ (NSString *)serviceDomain:(IGURLHostType)type
{
    return [[self sharedInstance] originServiceDomain:type];
}

+ (NSString *)urlWithPath:(NSString *)path
{
    return [self securityURLWithPath:path];
}

+ (NSString *)securityURLWithPath:(NSString *)path
{
    return [self urlUnderHostType:IGURLHostB2CType path:path];
}

+ (NSString *)urlUnderHostType:(IGURLHostType)type path:(NSString *)path
{
    NSString * host = [[self sharedInstance] originServiceDomain:type];
    NSString * scheme = [[self sharedInstance] urlSchemeForType:type];
    IGURL * url = [IGURL urlWithScheme:scheme host:host path:path];
    return [[url buildUrl] absoluteString];
}

+ (NSString *)outURLHost
{
    return @"yonghuivip.com";
}

#pragma mark - domain 获取
- (NSString *)urlSchemeForType:(IGURLHostType)type
{
    return [self.urlConfig schemeForType:type];
}

- (NSString *)originServiceDomain:(IGURLHostType)type
{
    return [self.urlConfig hostForType:type];
}

#pragma mark - init
- (instancetype)init
{
    if (self = [super init]) {
        self.urlConfig = [IGURLHostConfig new];
    }
    return self;
}
@end


#if defined(ISDebugOptionValid)
@implementation IGURLHostConfig(debug)

+ (instancetype)defaultConfig
{
    return [[IGURLManager sharedInstance] urlConfig];
}

- (void)updateHost:(NSString *)host forType:(IGURLHostType)type
{
    if (nil == self.mutableURLConfig) {
        self.mutableURLConfig = [self.baseURLConfig mutableCopy];
    }
    [self.mutableURLConfig safeSetObject:host forKey:[NSNumber numberWithInt:type]];
}

+ (NSString *)baseHostFor:(IGURLHostType)type
{
    return [[[self defaultConfig] baseURLConfig] safeObjectForKey:[NSNumber numberWithInt:type]];
}
@end
#endif
