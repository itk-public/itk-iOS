//
//  GoodDetailModel.m
//  PR
//
//  Created by 黄小雪 on 2017/6/7.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "GoodDetailModel.h"

NSString *const couponIcon   =  @"icon";
NSString *const couponAction = @"action";

@implementation GoodDetailModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super initWithDictionary:dic]) {
        _mainImgs = [dic safeObjectForKey:@"mainimgs" hintClass:[NSArray class]];
        NSDictionary *evaluateDict = [dic safeObjectForKey:@"evaluate" hintClass:[NSDictionary class]];
        if (evaluateDict) {
            _evaluate = [EvaluateModel modelFromDictionary:evaluateDict];
            _evaluateTotalNum = [[evaluateDict safeObjectForKey:@"totalNum"]integerValue];
            CGFloat favorable = [[evaluateDict safeObjectForKey:@"favorableRate"]floatValue];
            _favorableRate = [NSString stringWithFormat:@"%%%.1f",favorable];
        }
        _product = [ProductOutline modelFromDictionary:[dic safeObjectForKey:@"product"]];
        _shopInfo = [ShopDescInfo modelFromDictionary:[dic safeObjectForKey:@"shop"]];
        _additionalInfo = [dic safeObjectForKey:@"additionalInfo" hintClass:[NSArray class]];
        _coupon = [dic safeObjectForKey:@"coupon" hintClass:[NSDictionary class]];
        _pictureDetail = [dic safeObjectForKey:@"pictureDetail" hintClass:[NSArray class]];
    }
    return self;
}
@end
