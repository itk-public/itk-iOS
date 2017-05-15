//
//  SecurityCodeAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/5/14.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SecurityCodeAPIInteract.h"

@interface SecurityCodeAPIInteract()<IGParserInterface>

@end
@implementation SecurityCodeAPIInteract

-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager securityURLWithPath:GetSecurityCode_URLPATH] andParams:@{@"phonenum":self.phoneNum?:@""}];
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
    return info;
}


@end
