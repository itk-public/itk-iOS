//
//  CartSellerUIModel.m
//  PR
//
//  Created by 黄小雪 on 15/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartShopUIModel.h"
#import "CartProductInfo.h"

@implementation CartShopUIModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        NSArray *productsTemp = [dic safeObjectForKey:@"products" hintClass:[NSArray class]];
        if ([productsTemp count]) {
             NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[productsTemp count]];
            for (NSDictionary *dict in productsTemp) {
                CartProductInfo *product = [CartProductInfo modelFromDictionary:dict];
                [tempArray safeAddObject:product];
            }
            _products = [NSArray arrayWithArray:tempArray];
        }
        _shopInfo = [ShopDescInfo modelFromDictionary:[dic safeObjectForKey:@"shop"]];
    }
    return self;
}
@end
