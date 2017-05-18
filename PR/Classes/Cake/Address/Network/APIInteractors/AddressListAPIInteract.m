//
//  AddressListAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/5/17.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "AddressListAPIInteract.h"
#import "AddressListModel.h"

@interface AddressListAPIInteract()<IGParserInterface>

@end

@implementation AddressListAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:DeliveryAddressList_URLPATH] andParams:nil];
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
    return [AddressListModel modelFromDictionary:info];
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
