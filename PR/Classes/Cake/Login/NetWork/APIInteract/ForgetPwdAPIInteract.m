//
//  ForgetPwdAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/5/15.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ForgetPwdAPIInteract.h"
#import "UserManager.h"

@interface ForgetPwdAPIInteract()<IGParserInterface>

@end
@implementation ForgetPwdAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager securityURLWithPath:ForgetPwd_URLPATH] andParams:@{@"phonenum":self.phoneNum?:@"",@"securitycode":self.securityCode?:@"",@"pwd":self.pwd?:@""}];
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