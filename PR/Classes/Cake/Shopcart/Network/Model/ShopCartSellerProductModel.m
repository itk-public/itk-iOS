//
//  CartProudctWithOtherInfoModel.m
//  YHClouds
//
//  Created by 黄小雪 on 15/10/27.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "ShopCartSellerProductModel.h"
#import "ErrorProtectCateGory.h"
#import "ShopDescInfo.h"


@interface ShopCartSellerProductModel()
{
    CartOtherInfoModel *_infoModel;
    NSMutableArray     *_productArr;
}
@end

@implementation ShopCartSellerProductModel
@synthesize infoModel  = _infoModel;
@synthesize productArr = _productArr;


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        NSDictionary *otherInfoDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [dict safeObjectForKey:@"priceTotal"],@"priceTotal",
                                       [dict safeObjectForKey:@"storeid"],@"storeid",
                                       nil];
        
        _infoModel                  = [CartOtherInfoModel cartOtherInfoModelWithDict:otherInfoDict];
        
        NSArray *productArr                = [dict objectForKey:@"products"];
        NSMutableArray *productArrM = [NSMutableArray array];
        for (NSDictionary *productDict in productArr)
        {
            ProductOutline *model             = [ProductOutline modelFromDictionary:productDict];
            CartOrderCellViewModel *viewModel = [[CartOrderCellViewModel alloc]initWithProduct:model];
            [productArrM addObject:viewModel];
        }
        _productArr = [NSMutableArray arrayWithArray:productArrM];
        CartOrderCellViewModel *viewModel = [productArrM safeObjectAtIndex:0];
        _infoModel.isOutDelivered         = viewModel.product.isOutDelivered;
        
        
        _sellerInfo  = [ShopDescInfo modelFromDictionary:[dict safeObjectForKey:@"seller" hintClass:[NSDictionary class]]];
        
    }
    return self;
}





+(instancetype)cartProudctWithOtherInfoModelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
