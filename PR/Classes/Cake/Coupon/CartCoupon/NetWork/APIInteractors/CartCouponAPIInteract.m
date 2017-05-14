//
//  CartCouponAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 20/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartCouponAPIInteract.h"
#import "CartCoupons.h"

@interface CartCouponAPIInteract()<IGParserInterface>

@end
@implementation CartCouponAPIInteract
-(BaseRequest *)networkRequest
{
    
    BaseRequest *request = [BaseRequest requsetWithURL:
                            [IGURLManager urlWithPath:Cart_GetCoupons_URLPATH]
                                             andParams:@{@"shopid":self.shopid?:@""}];
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
    return [CartCoupons modelFromDictionary:info];
}

#pragma mark - init
-(instancetype)init{
    if (self = [super init]) {
        _repeatPolicy = APIInteractPolicy_CancelPrevious;
    }
    return self;
}

@end
