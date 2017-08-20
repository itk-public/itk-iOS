//
//  AdjustDataSouceHandler.h
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/27.
//  Copyright © 2017年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartSellerListModel.h"
#import "CartTableViewDataSource.h"

@interface AdjustDataSouceHandler : NSObject
//根据限购的商品数据，调整数据源
//-(void)adjustDataSource:(CartSellerListModel *)sellerList
//        restrictedGoods:(RestrictedGoods *)restrictInfos;

/**
 *  判断购物车中是否有选中的商品的
 */
-(BOOL)isSeletedProductWithSection:(NSInteger)section
                        dataSource:(CartTableViewDataSource *)dataSource;

//判断一个商品是不是可正常购买的商品
-(BOOL)modelIsNormal:(CartOrderCellViewModel *)vm
             section:(NSInteger)section
          dataSource:(CartTableViewDataSource *)dataSource;
@end
