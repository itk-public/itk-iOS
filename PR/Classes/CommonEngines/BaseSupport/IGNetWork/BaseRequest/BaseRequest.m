//
//  BaseRequest.m
//  PR
//
//  Created by 黄小雪 on 10/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "BaseRequest.h"
#import "IGURL.h"
#import "TimeStampMananger.h"
#import "PRCAppConfig.h"
#import "UserManager.h"
#import "YHDeviceInfo.h"
#import "GTMBase64.h"
#import "JSON.h"
#import "IGUtilties.h"
#import "IGDataOperator.h"

@interface BaseRequest()
{
    HttpMethodType			m_httpMethod;
    NSMutableDictionary *	m_params;
    IGURL *					m_requestUrl;
    
    BOOL                    m_needPublicInfo;
    
    NSString            *   m_paramStr;
    BOOL                    m_isString;
}

@property (nonatomic,strong) IGURL               *  requestUrl;
@property (strong,nonatomic) NSMutableDictionary *params;


@end

@implementation BaseRequest

@synthesize param  = m_params;
@synthesize needPublicInfo = m_needPublicInfo;
@synthesize requestUrl = m_requestUrl;
@synthesize httpMethod = m_httpMethod;
@synthesize paramStr   = m_paramStr;
@synthesize isString   = m_isString;

+(instancetype)requsetWithURL:(id)urlStr andParams:(NSDictionary *)parmas
{
    BaseRequest *newReq  = [[self alloc]init];
    [newReq setParam:parmas];
    if ([urlStr isKindOfClass:[NSString class]]) {
        [newReq setRequestUrl:[IGURL urlWithString:urlStr]];
    }else if ([urlStr isKindOfClass:[NSURL class]]){
        [newReq setRequestUrl:[IGURL urlWithNSURL:urlStr]];
    }else if ([urlStr isKindOfClass:[IGURL class]]){
        [newReq setRequestUrl:urlStr];
    }else{
        PRLOG(@"error ! Invalid url!");
    }
    return newReq;
}

+(instancetype)requsetWithURL:(id)urlStr andParamsString:(NSString *)parmasString
{
    BaseRequest *newReq = [[self alloc]init];
    [newReq setParamStr:parmasString];
    [newReq setIsString:YES];
    if ([urlStr isKindOfClass:[NSString class]])
    {
        [newReq setRequestUrl:[IGURL urlWithString:urlStr]];
    }
    else if ([urlStr isKindOfClass:[NSURL class]])
    {
        [newReq setRequestUrl:[IGURL urlWithNSURL:urlStr]];
    }
    else if ([urlStr isKindOfClass:[IGURL class]])
    {
        [newReq setRequestUrl:urlStr];
    }
    else
    {
        NSLog(@"error ！ Invalid Url!");
    }
    return newReq;
}

#pragma mark - inner interface

-(IGURL *)baseURL{
    return m_requestUrl;
}

-(NSString *)requestURL
{
    IGURL *assembURL = [IGURL urlWithIGURL:m_requestUrl];
    //添加所有参数
    NSDictionary *allParams = self.requestParams;
    NSString     *theKey    = nil;
    NSEnumerator *enumerator = [allParams keyEnumerator];
    while (theKey = [enumerator nextObject]) {
        [assembURL setQuery:[allParams safeObjectForKey:theKey] forKey:theKey];
    }
    //添加验证
    return [[assembURL buildUrl]absoluteString];
}

-(NSDictionary *)requestParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.httpMethod == kHttpMethodGet) {
        [params addEntriesFromDictionary:self.params];
    }
    NSDictionary *publicParams = [self publicParams];
    if ([[publicParams allKeys] count]) {
        [params addEntriesFromDictionary:publicParams];
    }
    
    NSDictionary *signInfo = [self signInfoFor:m_requestUrl withParams:params andPostBody:[[self postJSONDict] JSONRepresentation]];
    if ([[signInfo allKeys] count]) {
        [params addEntriesFromDictionary:signInfo];
    }
    return params;
}

-(NSDictionary *)postJSONDict
{
    if (self.httpMethod == kHttpMethodPost) {
        return m_params;
    }
    return nil;
}

#pragma mark -private methods
-(NSDictionary *)publicParams
{
#define kNetworkPlatformiOS      @"ios"
    CONDITION_CHECK_RETURN_VAULE(self.needPublicInfo, nil);
    NSMutableDictionary *pbParams = [NSMutableDictionary dictionary];
    NSString *timestamp = [NSString stringWithFormat:@"%.0f",[[TimeStampMananger shareManager] timeStamp] * 1000];
    [pbParams safeSetObject:timestamp forKey:@"timestamp"];
    [pbParams safeSetObject:kNetworkPlatformiOS forKey:@"platform"];
    [pbParams safeSetObject:[NSString stringWithFormat:@"%ld",(long)[PRCAppConfig appChannel]] forKey:@"channel"];
    
    NSDictionary* infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString* curVer = [infoDic objectForKey:(NSString*)kCFBundleVersionKey];
    [pbParams safeSetObject:curVer forKey:@"v"];
    
    // 用户处于登录状态，则传递
    if ([[UserManager shareMananger] isUserLogin])
    {
        [pbParams safeSetObject:[[[UserManager shareMananger] userData] uid] forKey:@"uid"];
        [pbParams safeSetObject:[[[UserManager shareMananger] userData] uToken] forKey:@"access_token"];
    }
    
    if ([[YHDeviceInfo sharedInstance] deviceID]) {
        [pbParams safeSetObject:[[YHDeviceInfo sharedInstance] deviceID] forKey:@"deviceid"];
    }

    return pbParams;
}

- (NSString *)pathForResource:(NSString *)name ofType:(NSString *)type{
    return [[NSBundle mainBundle]pathForResource:name ofType:type inDirectory:@"IGNResource.bundle"];
}

-(NSString *)securtKey
{
    static NSString * key = nil;
    if (key == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSString * filePath = [self pathForResource:@"Key" ofType:@"sc"];
            NSString * oriKey = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            
            // 一次decode
            NSString * oneDecoded = [[NSString alloc ]initWithData:[GTMBase64 decodeString:oriKey]encoding:NSUTF8StringEncoding];
            
            // 字符映射
            NSMutableString * mapCode = [NSMutableString new];
            const char * cInfo = [oneDecoded cStringUsingEncoding:NSUTF8StringEncoding];
            for (NSInteger index = 0 ; index < [oneDecoded length]; index++) {
                char mapChar = cInfo[index] - 4;
                if (mapChar <= 47) {
                    mapChar = 122 - (47 - mapChar);
                }
                [mapCode insertString:[NSString stringWithFormat:@"%c",mapChar] atIndex:index];
            }
            
            // 切断转移
            NSInteger onePartLength = [mapCode length] / 3;
            NSString * firstPart = [mapCode substringWithRange:NSMakeRange(0, onePartLength)];
            NSString * secPart = [mapCode substringWithRange:NSMakeRange(onePartLength, onePartLength)];
            NSString * endPart = [mapCode substringFromIndex:onePartLength * 2];
            NSString * swithCode = [NSString stringWithFormat:@"%@%@%@",endPart,secPart,firstPart];
            
            // 二次decode
            key =  [[NSString alloc ]initWithData:[GTMBase64 decodeString:swithCode] encoding:NSUTF8StringEncoding];
        });
    }
    return key;

}


- (NSDictionary *)signInfoFor:(IGURL *)url withParams:(NSDictionary *)param andPostBody:(NSString *)jsonData
{
    CONDITION_CHECK_RETURN_VAULE(self.needPublicInfo, nil);
    NSMutableArray *queryStrs = [NSMutableArray array];
    
    //取url中已经存在的参数
    NSDictionary *querys = [url allQueryPairs];
    NSString *theKey = nil;
    NSEnumerator *enumerator= [querys keyEnumerator];
    while (theKey = [enumerator nextObject]) {
        [queryStrs addObject:[NSString stringWithFormat:@"%@%@",theKey,[querys safeObjectForKey:theKey]]];
    }
         
    // 将所有的参数进行一个排列
    enumerator = [param keyEnumerator];
    while (theKey = [enumerator nextObject])
    {
        [queryStrs addObject:[NSString stringWithFormat:@"%@%@",theKey,[param safeObjectForKey:theKey]]];
    }
    
    
    [queryStrs sortUsingSelector:@selector(compare:)];
    NSString* paramsInfo = [queryStrs componentsJoinedByString:@""];
    
    // 添加post json内容
    if ([jsonData length] > 0)
    {
        paramsInfo = [paramsInfo stringByAppendingString:jsonData];
    }
    
    //添加密钥
    paramsInfo = [NSString stringWithFormat:@"%@%@",[self securtKey],paramsInfo];
    
    // 做MD5
    NSString* sig = [IGDataOperator md5:paramsInfo];
    if (sig.length > 0)
    {
        return @{@"sign":[IGUtilties encodeURL:sig]};
    }
    return nil;
         
}

#pragma mark - init
-(instancetype)init{
    if (self = [super init]) {
        m_needPublicInfo = YES;
        m_httpMethod = kHttpMethodGet;
        self.isOutsideVisit = NO;
    }
    return self;
}
@end
