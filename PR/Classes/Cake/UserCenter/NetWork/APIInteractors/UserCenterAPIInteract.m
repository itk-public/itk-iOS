//
//  UserCenterAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 21/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "UserCenterAPIInteract.h"
#import "UserCenterModel.h"

@interface UserCenterAPIInteract()<IGParserInterface>

@end

@implementation UserCenterAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request  = [BaseRequest requsetWithURL:[IGURLManager securityURLWithPath:MemberInfo_URLPATH ]  andParams:nil];
    request.httpMethod     = kHttpMethodGet;
    request.needPublicInfo = YES;
    return request;
}

-(id<IGParserInterface>)modelParser
{
    return self;
}

-(id)parserSourceData:(NSDictionary *)info forRespondObj:(BaseRespond *)respond
{
    UserCenterModel *model = [UserCenterModel modelFromDictionary:info];
    return model;
}

@end
