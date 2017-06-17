//
//  SearchShopDescInfo.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "SearchShopDescInfo.h"

@implementation SearchShopDescInfo
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    NSDictionary *shopInfo = [dic safeObjectForKey:@"shop"];
    if (self = [super initWithDictionary:shopInfo]) {
        NSInteger deliverTime = [[dic safeObjectForKey:@"deliverTime"]integerValue];
        _deliveryTimeStr = [NSString stringWithFormat:@"%zd分钟",deliverTime];
        _allocationType  = [dic safeObjectForKey:@"allocationType"];
    }
    return self;
}
@end
