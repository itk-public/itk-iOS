//
//  AccoutLoginAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "AccoutLoginAPIInteract.h"
#import "UserManager.h"

@interface AccoutLoginAPIInteract()<IGParserInterface>

@end
@implementation AccoutLoginAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager securityURLWithPath:PhoneLogin_URLPATH ] andParams:@{@"phonenum":self.phoneNum?:@"",@"pwd":self.pwd?:@""}];
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
