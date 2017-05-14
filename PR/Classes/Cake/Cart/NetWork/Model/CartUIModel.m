//
//  CartUIModel.m
//  PR
//
//  Created by 黄小雪 on 15/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "CartUIModel.h"
#import "CartShopUIModel.h"

@implementation CartUIModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        NSArray *cartlist = [dic safeObjectForKey:@"cartlist" hintClass:[NSArray class]];
        if ([cartlist count]) {
            NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[cartlist count]];
            for (NSDictionary *dict in cartlist) {
                CartShopUIModel *info = [CartShopUIModel modelFromDictionary:dict];
                [tempArray safeAddObject:info];
            }
            _cartList = [NSArray arrayWithArray:tempArray];
        }
        
        _pricetotal = [NSString stringWithFormat:@"%.2f", [[dic safeObjectForKey:@"pricetotal" hintClass:[NSNumber class]]integerValue]/100.0];
    }
    return self;
}
@end
