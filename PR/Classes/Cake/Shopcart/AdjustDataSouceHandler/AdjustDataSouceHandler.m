//
//  AdjustDataSouceHandler.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/27.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "AdjustDataSouceHandler.h"
//#import "ShipAddrManager.h"
//#import "CopyDescription+ShopCart.h"

@implementation AdjustDataSouceHandler
//-(void)adjustDataSource:(CartSellerListModel *)sellerList
//        restrictedGoods:(RestrictedGoods *)restrictInfos
//{
//    for (ShopCartSellerProductModel  *infoModel in sellerList.sellerArray) {
//        if ([infoModel isKindOfClass:[ShopCartSellerProductModel  class]]
//            && [infoModel.sellerInfo.cid isEqualToString:restrictInfos.sellerid]) {
//            for (CartOrderCellViewModel *vm in  infoModel.productArr) {
//                if ([vm isKindOfClass:[CartOrderCellViewModel class]] && vm.product.cid.length) {
//                    for (RestrictedGood *restricte in restrictInfos.goods) {
//                        if ([restricte isKindOfClass:[RestrictedGood class]] &&
//                            restricte.skucode.length &&
//                            [restricte.skucode isEqualToString:vm.product.cid]) {
//                            vm.product.restricemsg = restricte.restrictmsg;
//                        }
//                    }
//                }
//            }
//        }
//    }
//}

/**
 *  判断购物车中是否有选中的商品的
 */
-(BOOL)isSeletedProductWithSection:(NSInteger)section
                        dataSource:(CartTableViewDataSource *)dataSource{
    CartSectionData *setionData = [dataSource sellerProductAtSection:section];;
    CartDataHandle *dataHandle  = setionData.dataHandle;
    NSArray *selectedProducts             = [dataHandle productSeleted];
    NSString *promtStr = nil;
    if (!selectedProducts || selectedProducts.count == 0 ) {
        promtStr = @"这里有文案";
        if ([dataHandle countOfNormalArr] == 0) {
            if([dataHandle countOfOutOfStockArr]){
                promtStr = @"请将库存不足商品修改后方能继续结算";
            }
            if ([dataHandle countOfOffTheShelfArr]) {
                promtStr =@"countOfOffTheShelfArr";
            }
            
            if([dataHandle countOfOutOfDelivered]){
//                DeliveryInfo * deliveryInfoM = [[ShipAddrManager sharedInstance] deliveryInfo];
                promtStr = @"商品不支持自提，无法结算";
            }
        }
        if (promtStr) {
//            [YHShowToastUtil showNotice:promtStr];
            return NO;
        }
    }
    return YES;
}


-(BOOL)modelIsNormal:(CartOrderCellViewModel *)vm
             section:(NSInteger)section
          dataSource:(CartTableViewDataSource *)dataSource
{
    CartSectionData *setionData = [dataSource sellerProductAtSection:section];
    BOOL isNormal = !(vm.product.isOutOfStock |
                      vm.product.isOffTheShelf |
                      vm.product.isOutDelivered);
    if (setionData.editType == ShopcartEditTypeAll) {
        isNormal  = YES;
    }
    return isNormal;
}

@end
