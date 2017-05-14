//
//  CartMananger.m
//  YHClouds
//
//  Created by 黄小雪 on 16/8/1.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartMananger.h"
#import "LocalShopCartProduct.h"


@implementation CartMananger

//-(LocalShopCartHandle *)defaultLocalShopCartHandle
//{
//   return [[ServiceCenter defaultCenter] standarLocalShopCartHandle];
//}


-(instancetype)init{
    if (self = [super init]) {
        _cartShopAPI          = [[CartShopAPI alloc]init];
//        _cartDataHandle       = [self defaultLocalShopCartHandle];
    }
    return self;
}

-(void)setApiDelegate:(id<CartShopAPIDelegate>)apiDelegate
{
    _apiDelegate              = apiDelegate;
    self.cartShopAPI.delegate = _apiDelegate;
}

-(void)refreshCartDataWithMerid:(NSString *)merid
{
//    [self.cartShopAPI refreshCartDataWithProductArr:[self.cartDataHandle cartArrWithMerid:merid]];
}

-(void)csxRefreshCartDataWithMerid:(NSString *)merid
{
//    [self.cartShopAPI refreshCSXCartDataWithProductArr:[self.cartDataHandle cartArrWithMerid:merid]];
}

- (void)synchronizeLocalCartWithData:(id)data
{
//    if (data && [data isKindOfClass:[CartSellerListModel class]]) {
//        NSArray * tempSellerProducts = [(CartSellerListModel *)data sellerArray];
//        if (tempSellerProducts.count) {
//            [self.cartDataHandle clearLocalShopCart];
//            for (ShopCartSellerProductModel  * tModel in tempSellerProducts) {
//                NSArray * tProducts = tModel.productArr;
//                for (CartOrderCellViewModel *tProModel in tProducts) {
//                    ProductOutline *tP = tProModel.product;
//                    [self.cartDataHandle updateNumWithCid:tP.cid num:tP.num merid:tP.seller extraInfo:nil];
//                }
//            }
//        }
//    }
}

- (void)mergeLocalCartAndCloudData:(id)data
{
//    NSArray * localCartArr = [self.cartDataHandle cartArrWithMerid:nil];
//    NSMutableDictionary * productNumDic    = [NSMutableDictionary dictionary];
//    for (NSDictionary * tSellerProductDic in localCartArr) {
//        NSString * sellerIdStr = [NSString stringWithFormat:@"%@", tSellerProductDic[@"sellerid"]?:@""];
//        NSArray * tPArr = tSellerProductDic[@"products"];
//        for (NSDictionary * tProductDic in tPArr) {
//            CGFloat productCount = [[NSString stringWithFormat:@"%@", tProductDic[@"num"]?:@""] floatValue]/100;
//            NSInteger selected = [[NSString stringWithFormat:@"%@", tProductDic[@"selectstate"]?:@""] integerValue];
//            [productNumDic safeSetObject:@(productCount) forKey:tProductDic[@"id"]?:@""];
//            [self.cartDataHandle updateWithCid:tProductDic[@"id"]?:@"" num:productCount selectstate:selected merid:sellerIdStr extraInfo:nil];
//        }
//    }
//    if (data && [data isKindOfClass:[CartSellerListModel class]]) {
//        NSArray * tempSellerProducts = [(CartSellerListModel *)data sellerArray];
//        if (tempSellerProducts.count) {
//            for (ShopCartSellerProductModel  * tModel in tempSellerProducts) {
//                NSArray * tProducts = tModel.productArr;
//                for (CartOrderCellViewModel *tProModel in tProducts) {
//                    ProductOutline *tP = tProModel.product;
//                    CGFloat newNum = tP.num + (productNumDic[tP.cid?:@""]?[productNumDic[tP.cid?:@""] floatValue]:0);
//                    [self.cartDataHandle updateWithCid:tP.cid num:newNum selectstate:tP.isSelected merid:tP.seller extraInfo:nil];
//                }
//            }
//        }
//    }
}
@end
