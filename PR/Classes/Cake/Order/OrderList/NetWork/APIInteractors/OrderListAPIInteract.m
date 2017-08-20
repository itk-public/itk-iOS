//
//  OrderListAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderListAPIInteract.h"
#import "OrderDetail.h"
#import "OrderListModel.h"
#import "PartDataResponse.h"


@interface OrderListAPIInteract()<IGParserInterface,PartDataResponseItemParser>

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
    PartDataResponse * dataRespond = [[PartDataResponse alloc] initWithItemParser:self];
    [dataRespond loadDict:info];
    return dataRespond;
}

#pragma mark - PartDataResponseItemParser
-(NSString *)itemsParseKey
{
    return @"orders";
}

-(NSArray *)parseItemWithInfo:(NSArray *)info
{
    CONDITION_CHECK_RETURN_VAULE([info isKindOfClass:[NSArray class]], nil);
    NSMutableArray *itemObjs = [NSMutableArray array];
    for (NSDictionary *dict in info) {
        OrderDetail *orderDetail = [OrderDetail modelFromDictionary:dict];
        [itemObjs addObject:orderDetail];
    }
    return itemObjs;
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
