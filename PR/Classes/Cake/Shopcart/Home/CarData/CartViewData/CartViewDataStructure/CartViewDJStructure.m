//
//  CartViewData.m
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "CartViewDJStructure.h"
#import "CartSortData.h"
#import "CartOrderCellViewModel.h"
#import "ProductOutline.h"
#import "ProductSortElements.h"
#import "CartInfoDefine.h"
#import "ShopCartSellerProductModel.h"
#import "CartSeparateModel.h"

#import "DJProductSortElements.h"

@implementation CartViewDJStructure

- (CartViewData *)viewDataArray:(NSArray *)originalProductArray {
    CartViewData *cartViewData          = [[CartViewData alloc]init];
    cartViewData.dataArray       = (NSMutableArray *)originalProductArray;
    return cartViewData;
}

@end
