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
//
//    //根据当日达、次日达获取分类数据 并把有货、无货、下架数据分开
//    ProductSortElements *spliteElements = [[DJProductSortElements alloc]init];
//    [spliteElements splitElementsArray:originalProductArray];
//    
//    //获取各个部分的数据
//    NSMutableArray *sectionArray        = [[NSMutableArray alloc]init];
//    //当日达正常商品
//    NSArray *fastOnShelvesArray         = [spliteElements acquireDataOfCategory:PTDeliveryFast shelvesState:ProductsStateOnShelves];
//    //当日达库存不足
//    NSArray *fastOutStockArray          = [spliteElements acquireDataOfCategory:PTDeliveryFast shelvesState:ProductsStateOutStock];
//    //当日达已下架
//    NSArray *fastOffShelvesArray        = [spliteElements acquireDataOfCategory:PTDeliveryFast shelvesState:ProductsStateOffShelves];
//    //当日达超出配送范围
//    NSArray *fastOutDeliveredArray          = [spliteElements acquireDataOfCategory:PTDeliveryFast shelvesState:ProductsStateIsOutDelivered];
//    
//    
//    [sectionArray safeAddObjectsFromArray:fastOnShelvesArray];
//    [sectionArray safeAddObjectsFromArray:fastOutStockArray];
//    [sectionArray safeAddObjectsFromArray:fastOffShelvesArray];
//    [sectionArray safeAddObjectsFromArray:fastOutDeliveredArray];
//    if ([fastOffShelvesArray count]){
//        CartOrderCellViewModel *vm = [sectionArray lastObject];
//        if (vm) {
//            vm.bottomLineHide = YES;
//        }
//#warning 文案待定
//        CartSeparateModel *separate = [[CartSeparateModel alloc]init];
//        [separate updateTitle:@"以下商品已下架" isSalePrompt:NO];
//        [sectionArray safeAddObject:separate];
//        [sectionArray safeAddObjectsFromArray:fastOffShelvesArray];
//    }
//    if ([fastOutDeliveredArray count]) {
//        if (((CartOrderCellViewModel *)[fastOutDeliveredArray safeObjectAtIndex:0]).isShopOutDelivered == NO) {
//            CartOrderCellViewModel *vm = [sectionArray lastObject];
//            if (vm) {
//                vm.bottomLineHide = YES;
//            }
//            CartSeparateModel *separate = [[CartSeparateModel alloc]init];
//#warning 文案待定
//            [separate updateTitle:@"一下商品不在配送范围内容文档待定" isSalePrompt:NO];
//            [sectionArray safeAddObject:separate];
//        }
//        [sectionArray safeAddObjectsFromArray:fastOutDeliveredArray];
//    }
    
//    cartViewData.dataArray     = sectionArray;
//    cartViewData.productSort   = spliteElements;
    cartViewData.dataArray       = (NSMutableArray *)originalProductArray;
    return cartViewData;
}

@end
