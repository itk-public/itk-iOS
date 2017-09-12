//
//  ShopCartDiscountModel.m
//  PR
//
//  Created by 黄小雪 on 2017/9/11.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopCartDiscountModel.h"

@implementation ShopCartDiscountModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        _tag = [dic safeObjectForKey:@"tag" hintClass:[NSString class]];
        _title = [dic safeObjectForKey:@"title" hintClass:[NSString class]];
        _subtitle = [dic safeObjectForKey:@"subtitle" hintClass:[NSString class]];
    }
    return self;
}
@end
