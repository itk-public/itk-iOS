//
//  SellerDescInfo.m
//  PR
//
//  Created by 黄小雪 on 15/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ShopDescInfo.h"

@implementation ShopDescInfo
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super initWithDictionary:dic]) {
        NSString *actionStr = [dic safeObjectForKey:@"action"];
        if ([actionStr length]) {
            _action = [Action actionWithString:actionStr];
        }
        
        _cityname = [dic safeObjectForKey:@"cityname"];
        NSString *iconStr = [dic safeObjectForKey:@"icon"];
        if ([iconStr length]) {
            _icon = [[ImageInfo alloc]initWithImageURL:iconStr];
        }
        _cid = [dic safeObjectForKey:@"id"];
        _shopname = [dic safeObjectForKey:@"shopname"];
        _title      = [dic safeObjectForKey:@"title"];
    }
    return self;
}
@end
