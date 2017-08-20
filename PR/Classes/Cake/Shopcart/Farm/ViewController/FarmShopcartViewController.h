//
//  ShopcartViewController.h
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/26.
//  Copyright © 2017年 YH. All rights reserved.
//

#import "AsynDataLoadViewController.h"
@class CartTableViewDataSource;
@class ProductOutline;
@class CartMananger;

@interface FarmShopcartViewController : AsynDataLoadViewController
{
@protected
    CartTableViewDataSource     *cartDataSoure;
    
    // --- 外部添加的商品临时存储信息---
    NSArray<ProductOutline *>   * outerProductsToAdd;
}
@end
