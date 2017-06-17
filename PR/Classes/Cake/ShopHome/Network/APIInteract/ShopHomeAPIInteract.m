//
//  ShopHomeAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeAPIInteract.h"
#import "ShopHomeDetailInfo.h"

@interface ShopHomeAPIInteract()<IGParserInterface>

@end
@implementation ShopHomeAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:ShopHome_URLPATH] andParams:nil];
    request.needPublicInfo = YES;
    request.httpMethod     = kHttpMethodPost;
    return request;
}

- (id<IGParserInterface>)modelParser
{
    return self;
}


#pragma mark IGParserInterface
- (id)parserSourceData:(NSDictionary *)info forRespondObj:(BaseRespond *)respond{
    CONDITION_CHECK_RETURN_VAULE([info isKindOfClass:[NSDictionary class]], nil);
    return [ShopHomeDetailInfo modelFromDictionary:info];
}

#pragma mark init
- (instancetype) init
{
    if (self = [super init]) {
        _repeatPolicy = APIInteractPolicy_CancelPrevious;
    }
    return self;
}

@end
