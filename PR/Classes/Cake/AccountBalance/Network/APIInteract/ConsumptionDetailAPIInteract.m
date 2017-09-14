//
//  ConsumptionDetailAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/9/13.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ConsumptionDetailAPIInteract.h"
#import "ConsumptionDetailModel.h"
@interface ConsumptionDetailAPIInteract()<IGParserInterface>

@end
@implementation ConsumptionDetailAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:ConsumptionDetail_URLPATH] andParams:nil];
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
    NSArray *tempCousumption = [info safeObjectForKey:@"cousumption" hintClass:[NSArray class]];
    NSMutableArray *cousumptionArrM = [NSMutableArray arrayWithCapacity:[tempCousumption count]];
    if (tempCousumption) {
        for (NSDictionary *dict in tempCousumption) {
            ConsumptionDetailModel *detailModel = [ConsumptionDetailModel modelFromDictionary:dict];
            [cousumptionArrM safeAddObject:detailModel];
            
        }
    }
    return cousumptionArrM;
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
