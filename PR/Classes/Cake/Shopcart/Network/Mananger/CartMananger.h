//
//  CartMananger.h
//  YHClouds
//
//  Created by 黄小雪 on 16/8/1.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartShopAPI.h"
//#import "SellerDefine.h"
//#import "LocalShopCartHandle.h"
#import "CartSellerListModel.h"


@interface CartMananger : NSObject
@property (strong,nonatomic) CartShopAPI            *cartShopAPI;
@property (weak,nonatomic  ) id<CartShopAPIDelegate> apiDelegate;
//@property (strong,nonatomic) LocalShopCartHandle   *cartDataHandle;

- (void)refreshCartDataWithMerid:(NSString *)merid;

- (void)csxRefreshCartDataWithMerid:(NSString *)merid;

- (void)doFetchCloudCart;

- (void)synchronizeLocalCartWithData:(id)data;

- (void)mergeLocalCartAndCloudData:(id)data;

@end
