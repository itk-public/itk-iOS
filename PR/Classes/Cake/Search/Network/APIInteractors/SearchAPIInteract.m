//
//  SearchAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SearchAPIInteract.h"
#import "SearchResultModel.h"

@interface SearchAPIInteract()<IGParserInterface>

@end
@implementation SearchAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:SearchSku_URLPATH ] andParams:nil];
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
    NSArray *searchList = [info safeObjectForKey:@"searchList" hintClass:[NSArray class]];
    if (searchList) {
        NSMutableArray *tempSearch = [NSMutableArray arrayWithCapacity:[searchList count]];
        for (NSDictionary *dic in searchList) {
            [tempSearch safeAddObject:[SearchResultModel modelFromDictionary:dic]];
        }
        return tempSearch;
    }
    return nil;
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
