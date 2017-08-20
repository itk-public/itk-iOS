//
//  FarmAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/8/6.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "FarmAPIInteract.h"
#import "DynamicUIModel.h"

@interface FarmAPIInteract()<IGParserInterface>

@end
@implementation FarmAPIInteract

-(BaseRequest *)networkRequest
{
    
    BaseRequest *request = [BaseRequest requsetWithURL:
                            [IGURLManager urlWithPath:DynamicData_URLPATH]
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
    return [DynamicUIModel modelFromDictionary:info];
}

#pragma mark - init
-(instancetype)init{
    if (self = [super init]) {
        _repeatPolicy = APIInteractPolicy_CancelPrevious;
    }
    return self;
}


@end
