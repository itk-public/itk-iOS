//
//  OrderSettlementAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/8/22.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderSettlementAPIInteract.h"
#import "OrderDetail.h"

@interface OrderSettlementAPIInteract()<IGParserInterface>

@end
@implementation OrderSettlementAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:OrderPlace_URLPATH ] andParams:nil];
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
