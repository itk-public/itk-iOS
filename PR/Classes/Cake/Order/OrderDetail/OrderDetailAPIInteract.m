//
//  OrderDetailAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/9/13.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderDetailAPIInteract.h"
#import "OrderDetail.h"

@interface OrderDetailAPIInteract()<IGParserInterface>

@end
@implementation OrderDetailAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:OrderDetail_URLPATH] andParams:nil];
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
    return [OrderDetail modelFromDictionary:info];
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

