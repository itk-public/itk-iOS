//
//  LocalShopCartProduct.m
//  YHClouds
//
//  Created by 黄小雪 on 16/8/2.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "LocalShopCartProduct.h"

@implementation LocalShopCartProduct
- (NSDictionary *)convertToDict
{
    NSMutableDictionary * paramDict   = [NSMutableDictionary dictionary];
    [paramDict safeSetObject:self.cid forKey:@"id"];
    [paramDict safeSetObject:@(self.num) forKey:@"num"];
    [paramDict safeSetObject:@(self.selectstate) forKey:@"selectstate"];
    return paramDict;
}

-(NSDictionary *)trackLogConvertToDict
{
    NSMutableDictionary * paramDict   = [NSMutableDictionary dictionary];
    [paramDict safeSetObject:self.cid forKey:@"skucode"];
    [paramDict safeSetObject:@(self.num) forKey:@"num"];
    [paramDict safeSetObject:[NSString stringWithFormat:@"%.2f",[self.price integerValue]/100.0] forKey:@"price"];
    [paramDict safeSetObject:self.stacktitle forKey:@"path"];
    [paramDict safeSetObject:self.updatetime forKey:@"timestamp"];
    return paramDict;
}
@end
