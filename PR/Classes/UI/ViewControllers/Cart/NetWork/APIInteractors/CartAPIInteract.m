//
//  CartAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 15/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartAPIInteract.h"
#import "CartUIModel.h"

@interface CartAPIInteract()<IGParserInterface>

@end
@implementation CartAPIInteract

-(BaseRequest *)networkRequest
{
    
    BaseRequest *request = [BaseRequest requsetWithURL:
                            [IGURLManager urlWithPath:Cart_URLPATH]
                                             andParams:nil];
    request.needPublicInfo = YES;
    request.httpMethod     = kHttpMethodGet;
    return request;
}

-(id<IGParserInterface>)modelParser
{
    return self;
}

#pragma mark - IGParserInterface
-(id)parserSourceData:(NSDictionary *)info forRespondObj:(BaseRespond *)respond
{
    return [CartUIModel modelFromDictionary:info];
}

#pragma mark - init
-(instancetype)init{
    if (self = [super init]) {
        _repeatPolicy = APIInteractPolicy_CancelPrevious;
    }
    return self;
}

@end
