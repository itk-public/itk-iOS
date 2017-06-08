//
//  GoodDetailAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodDetailAPIInteract.h"
#import "GoodDetailModel.h"

@interface GoodDetailAPIInteract()<IGParserInterface>
@end

@implementation GoodDetailAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:GoodDetail_URLPATH] andParams:nil];
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
    return [GoodDetailModel modelFromDictionary:info];
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
