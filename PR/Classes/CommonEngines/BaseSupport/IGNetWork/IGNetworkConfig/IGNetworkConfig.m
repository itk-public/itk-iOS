//
//  IGNetworkConfig.m
//  PR
//
//  Created by 黄小雪 on 13/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "IGNetworkConfig.h"
#import "IGUtilties.h"
#import "ErrorProtectCateGory.h"

@interface IGNetworkConfig()

@property (strong,nonatomic) NSString *httpUA;
@property (strong,nonatomic) NSDictionary *httpPublicParams;
@property (strong,nonatomic) NSString *httpProfessionParamStr;
@property (strong,nonatomic) IGErrorHandler *errorHandler;

@end

@implementation IGNetworkConfig

+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id __singleton__;
    dispatch_once(&once, ^{
        __singleton__ = [[self alloc]init];
    });
    
    return __singleton__;
}

-(void)registerNetworkUA:(NSString *)userAgent
{
    self.httpUA = userAgent;
}

-(void)updateProfessionalParam:(NSDictionary *)param
{
    NSString *paramStr = @"";
    NSDictionary *professionalParams = param;
    for (NSString *aKey in [professionalParams allKeys]) {
        if ([paramStr length]) {
            paramStr = [paramStr stringByAppendingString:@"&"];
        }
        NSString *aValue = [professionalParams safeObjectForKey:aKey hintClass:[NSString class]];
        if (aValue && aKey) {
            paramStr = [paramStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",[IGUtilties encodeURL:aKey],
                                                          [IGUtilties encodeURL:aValue]]];
        }
    }
    self.httpProfessionParamStr = paramStr;
}

-(void)updateRequestPublicParam:(NSDictionary *)param
{
    self.httpPublicParams = param;
}

-(NSString *)userAgent
{
    return self.httpUA;
}

-(NSString *)professionalParamStr;
{
    return self.httpProfessionParamStr;
}

- (NSDictionary *)publicParams
{
    return self.httpPublicParams;
}
@end
