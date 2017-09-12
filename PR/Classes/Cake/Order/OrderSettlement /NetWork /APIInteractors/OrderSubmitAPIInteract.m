//
//  OrderSubmitAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/9/12.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderSubmitAPIInteract.h"

@interface OrderSubmitAPIInteract()<IGParserInterface>

@end
@implementation OrderSubmitAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:OrderSubmit_URLPATH] andParams:nil];
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
    return info;
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

