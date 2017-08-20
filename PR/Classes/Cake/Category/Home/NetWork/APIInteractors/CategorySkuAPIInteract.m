//
//  CategorySkuAPIInteract.m
//  PR
//
//  Created by 黄小雪 on 2017/6/5.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "CategorySkuAPIInteract.h"
#import "SubCategoryModel.h"

@interface CategorySkuAPIInteract()<IGParserInterface>

@end
@implementation CategorySkuAPIInteract
-(BaseRequest *)networkRequest
{
    BaseRequest *request = [BaseRequest requsetWithURL:[IGURLManager urlWithPath:CategorySku_URLPATH ] andParams:@{@"categoryId":self.categoryId?:@""}];
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
    NSArray *tempSkus = [info safeObjectForKey:@"skus" hintClass:[NSArray class]];
    if (tempSkus && [tempSkus count]) {
         NSMutableArray *skus = [NSMutableArray arrayWithCapacity:[tempSkus count]];
        for (NSDictionary *dict in tempSkus) {
            SubCategoryModel *model = [SubCategoryModel modelFromDictionary:dict];
            [skus safeAddObject:model];
        }
        return skus;
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
