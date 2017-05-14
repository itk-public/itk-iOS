//
//  PhoneQuickLoginAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "PhoneQuickLoginAPIInteract.h"
#import "IGURLManager.h"
#import "UserManager.h"

@interface PhoneQuickLoginAPIInteract()<IGParserInterface>

@end

@implementation PhoneQuickLoginAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager securityURLWithPath:PhoneLogin_URLPATH ] andParams:@{@"phonenum":self.phoneNum?:@"",@"securitycode":self.safetyCode?:@""}];
    request.httpMethod   = kHttpMethodGet;
    return request;
}

-(id<IGParserInterface>)modelParser
{
    return self;
}

-(id)parserSourceData:(NSDictionary *)info forRespondObj:(BaseRespond *)respond
{
    CONDITION_CHECK_RETURN_VAULE([info isKindOfClass:[NSDictionary class]], nil);
    [[UserManager shareMananger]saveUserInfo:info];
    return info;
}
@end
