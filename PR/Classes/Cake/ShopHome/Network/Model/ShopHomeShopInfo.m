//
//  ShopHomeShopInfo.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeShopInfo.h"

@implementation ShopHomeShopInfo
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    NSDictionary *shop = [dic safeObjectForKey:@"shop"];
    if (self = [super initWithDictionary:shop]) {
        _score = [[dic safeObjectForKey:@"score"]integerValue];
        _isAttention = [[dic safeObjectForKey:@"isAttention"]boolValue];
        _attentionNum = [[dic safeObjectForKey:@"attentionNum"]integerValue];
    }
    return self;
}
@end
