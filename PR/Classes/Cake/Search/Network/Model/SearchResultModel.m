//
//  SearchResultModel.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        NSArray *tempPrdoucts = [dic safeObjectForKey:@"products" hintClass:[NSArray class]];
        if (tempPrdoucts) {
            NSMutableArray *productsArrM = [NSMutableArray arrayWithCapacity:[tempPrdoucts count]];
            for (NSDictionary *dict in tempPrdoucts) {
                ProductOutline *product = [ProductOutline modelFromDictionary:dict];
                [productsArrM safeAddObject:product];
            }
            _products = [[NSArray alloc]initWithArray:productsArrM];
            productsArrM = nil;
        }
        _shopInfo = [SearchShopDescInfo modelFromDictionary:dic];
        _totalNum = [[dic safeObjectForKey:@"totalNum"]integerValue];
    }
    return self;
}
@end
