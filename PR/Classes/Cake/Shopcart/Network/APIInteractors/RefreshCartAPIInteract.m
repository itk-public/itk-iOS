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
//-(BaseRequest *)networkRequest{
//    NSMutableDictionary * params  = [NSMutableDictionary dictionary];
//    if (self.productsArr) {
//         [params setObject:self.productsArr forKey:@"seller"];
//    }
//    [params safeSetObject:self.uid forKey:@"uid"];
//    BOOL pickSelf                 = [ShipAddrManager sharedInstance].deliveryInfo.pickselfStyle;
//    [params safeSetObject:(pickSelf? @(1) : @(0)) forKey:@"pickself"];
//    AcceptAddressModel * addrInfo = [ShipAddrManager sharedInstance].deliveryInfo.shareAddr;
//    BackLocationModel  * longitude  = [ShipAddrManager sharedInstance].deliveryInfo.overallSituationLocation;
//    [params safeSetObject:addrInfo.cid forKey:@"addressid"];
//    NSDictionary *location        = @{@"lng":longitude.lng?:@"",
//                               @"lat":longitude.lat?:@""};
//    [params safeSetObject:location forKey:@"location"];
//
//    BaseRequest *request          = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:CartMultiplace_URLPATH]
//                                             andParams:params];
//    request.needPublicInfo        = YES;
//    request.httpMethod            = kHttpMethodPost;
//    return request;
//}

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
