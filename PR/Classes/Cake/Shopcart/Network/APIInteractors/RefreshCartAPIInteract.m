//
//  RefreshCartAPIInteract.m
//  YHClouds
//
//  Created by 黄小雪 on 15/10/26.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "RefreshCartAPIInteract.h"
#import "IGNetwork.h"
#import "CartSellerListModel.h"


@interface RefreshCartAPIInteract()<IGParserInterface>

@end

@implementation RefreshCartAPIInteract
-(BaseRequest *)networkRequest{
    BaseRequest *request = [BaseRequest requsetWithURL:
                            [IGURLManager urlWithPath:Cart_URLPATH]
                                             andParams:nil];
    request.needPublicInfo = YES;
    request.httpMethod     = kHttpMethodGet;
    return request;
}

- (id<IGParserInterface>)modelParser
{
    return self;
}


#pragma mark IGParserInterface
- (id)parserSourceData:(NSDictionary *)info forRespondObj:(BaseRespond *)respond{
    CartSellerListModel *model = [CartSellerListModel modelFromDictionary:info];
    return model;
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
