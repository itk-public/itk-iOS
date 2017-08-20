//
//  ParameterHandler.m
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/27.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "ParameterHandler.h"
#import "UserManager.h"
#import "CartSectionData.h"

@implementation ParameterHandler
//+ (OrderGenerateParam *)generateParamAtSection:(NSInteger)section
//                                    dataSource:(CartTableViewDataSource *)dataSource
//{
//    CartSectionData *sellerData                = [dataSource sellerProductAtSection:section];
//    ShopCartSellerProductModel  *cartAllInfo   = sellerData.sellerProductModel;
//    CartDataHandle                *dataHandle  = sellerData.dataHandle;
//    OrderGenerateParam * generateInfo          = [[OrderGenerateParam alloc] init];
//    
//    generateInfo.products                      = [dataHandle productSeleted];
//    generateInfo.sellerid                      = cartAllInfo.sellerInfo.cid?:@"";
//    generateInfo.uid                           = [[[UserManager shareMananger] userData] uid];
//    generateInfo.storeID                       = cartAllInfo.infoModel.storeid?:@"";
//    generateInfo.autocoupon                    = YES;
//    
//    OptionState *option                        = [[OptionState alloc]init];
//    option.balancepayoption                    = YES;
//    option.freedeliveryoption                  = YES;
//    if ([ShipAddrManager sharedInstance].deliveryInfo.pickselfStyle) {
//        generateInfo.orderType     = OrderPickSelfType;
//    }else{
//        generateInfo.orderType     = OrderDeliveryType;
//        generateInfo.addrInfo                      = [ShipAddrManager sharedInstance].deliveryInfo.shareAddr;
//        
//    }
//    generateInfo.optionState         = option;
//    return generateInfo;
//
//}
@end
