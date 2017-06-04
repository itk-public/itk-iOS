//
//  PickSelfSiteListAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/5/30.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "PickSelfSiteListAPIInteract.h"
#import "PickSelfSiteModel.h"

@interface PickSelfSiteListAPIInteract()<IGParserInterface>

@end

@implementation PickSelfSiteListAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:PickSelfSiteList_URLPATH] andParams:nil];
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
    CONDITION_CHECK_RETURN_VAULE([info isKindOfClass:[NSDictionary class]],nil);
    NSArray *list = [info safeObjectForKey:@"siteList" hintClass:[NSArray class]];
    CONDITION_CHECK_RETURN_VAULE(list, nil);
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in list) {
        PickSelfSiteModel *model = [PickSelfSiteModel modelFromDictionary:dic];
        [tempArray safeAddObject:model];
    }
    return tempArray;
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
