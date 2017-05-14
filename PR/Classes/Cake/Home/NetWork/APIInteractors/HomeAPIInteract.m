//
//  HomeAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 12/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "HomeAPIInteract.h"
#import "IGURLManager.h"
#import "DynamicUIModel.h"

@interface HomeAPIInteract()<IGParserInterface>

@end

@implementation HomeAPIInteract
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
