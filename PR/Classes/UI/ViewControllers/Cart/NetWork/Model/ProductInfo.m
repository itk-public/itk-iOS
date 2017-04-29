//
//  ProductInfo.m
//  PR
//
//  Created by 黄小雪 on 20/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "ProductInfo.h"
@implementation PriceInfo
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    CONDITION_CHECK_RETURN_VAULE([dic isKindOfClass:[dic class]], nil);
    if (self = [super initWithDictionary:dic]) {
        NSNumber *marketNumber = [dic safeObjectForKey:@"market" hintClass:[NSNumber class]];
        if (marketNumber) {
            _marketPrice = [NSString stringWithFormat:@"%.02f",[marketNumber integerValue]/100.0];
        }
    }
    return self;
}
@end

@implementation ProductInfo
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        NSString *actionStr = [dic safeObjectForKey:@"action" hintClass:[NSString class]];
        if ([actionStr length]) {
            _action = [Action actionWithString:actionStr];
        }
        _isOffShelf = [[dic safeObjectForKey:@"vailable" hintClass:[NSNumber class]]boolValue];
        _cid        = [dic safeObjectForKey:@"id" hintClass:[NSString class]];
        NSString *imageurl = [dic safeObjectForKey:@"imgurl" hintClass:[NSString class]];
        if ([imageurl length]) {
            _imageInfo = [[ImageInfo alloc]initWithImageURL:imageurl];
        }
        NSInteger isdelivery = [[dic safeObjectForKey:@"isdelivery"]integerValue];
        _isOutDelivery = isdelivery == 0;
        _num = [[dic safeObjectForKey:@"num" hintClass:[NSNumber class]]integerValue]/100;
        _priceInfo = [PriceInfo modelFromDictionary:[dic safeObjectForKey:@"price"]];
        _isSelect  = [[dic safeObjectForKey:@"selectstate"]boolValue];
        _shopid    = [dic safeObjectForKey:@"shopid"];
        _spec      = [dic safeObjectForKey:@"spec"];
        _stocknum  = [[dic safeObjectForKey:@"stocknum"]integerValue]/100;
        _subtitle  = [dic safeObjectForKey:@"subtitle"];
        _title     = [dic safeObjectForKey:@"title"];
        
    }
    return self;
}


-(BOOL)isIsOutStock{
    if (self.num && self.num > self.stocknum) {
        return YES;
    }
    return NO;
}
@end
