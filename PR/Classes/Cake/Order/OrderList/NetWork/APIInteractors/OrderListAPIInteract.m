//
//  OrderListAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderListAPIInteract.h"
#import "OrderDetail.h"


@interface OrderListAPIInteract()<IGParserInterface>

@end
@implementation OrderListAPIInteract

-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:OrderList_URLPATH] andParams:nil];
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
    NSArray *categorys = [info safeObjectForKey:@"orders" hintClass:[NSArray class]];
    NSMutableArray *tempArray = [NSMutableArray array];
    if (categorys) {
        for (NSDictionary *tempDic in categorys) {
            ShopCategoryModel *model = [ShopCategoryModel modelFromDictionary:tempDic];
            [tempArray safeAddObject:model];
        }
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
