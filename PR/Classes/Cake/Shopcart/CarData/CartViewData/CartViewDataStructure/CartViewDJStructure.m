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
    
    //根据当日达、次日达获取分类数据 并把有货、无货、下架数据分开
    ProductSortElements *spliteElements = [[DJProductSortElements alloc]init];
    [spliteElements splitElementsArray:originalProductArray];
    
    //获取各个部分的数据
    NSMutableArray *sectionArray        = [[NSMutableArray alloc]init];
    //当日达正常商品
    NSArray *fastOnShelvesArray         = [spliteElements acquireDataOfCategory:PTDeliveryFast shelvesState:ProductsStateOnShelves];
    //当日达库存不足
    NSArray *fastOutStockArray          = [spliteElements acquireDataOfCategory:PTDeliveryFast shelvesState:ProductsStateOutStock];
    //当日达已下架
    NSArray *fastOffShelvesArray        = [spliteElements acquireDataOfCategory:PTDeliveryFast shelvesState:ProductsStateOffShelves];
    //当日达超出配送范围
    NSArray *fastOutDeliveredArray          = [spliteElements acquireDataOfCategory:PTDeliveryFast shelvesState:ProductsStateIsOutDelivered];
    
    
    //次日达正常商品
    NSArray *slowOnShelvesArray         = [spliteElements acquireDataOfCategory:PTDeliverySlow shelvesState:ProductsStateOnShelves];
    //次日达库存不足
    NSArray *slowOutStockArray          = [spliteElements acquireDataOfCategory:PTDeliverySlow shelvesState:ProductsStateOutStock];
    //次日达已下架
    NSArray *slowOffShelvesArray        = [spliteElements acquireDataOfCategory:PTDeliverySlow shelvesState:ProductsStateOffShelves];
    //次日达超出配送范围
    NSArray *slowOutDeliveredArray       = [spliteElements acquireDataOfCategory:PTDeliverySlow shelvesState:ProductsStateIsOutDelivered];
    
    //员工购商品
    
    
    //员工购商品正常商品
    NSArray *csxOnShelvesArray         = [spliteElements acquireDataOfCategory:PTDeliveryEP shelvesState:ProductsStateOnShelves];
    //员工购商品库存不足
    NSArray *csxOutStockArray          = [spliteElements acquireDataOfCategory:PTDeliveryEP shelvesState:ProductsStateOutStock];
    //员工购商品已下架
    NSArray *csxOffShelvesArray        = [spliteElements acquireDataOfCategory:PTDeliveryEP shelvesState:ProductsStateOffShelves];
    //员工购商品超出配送范围
    NSArray *csxOutDeliveredArray      = [spliteElements acquireDataOfCategory:PTDeliveryEP shelvesState:ProductsStateIsOutDelivered];
    
    if ([csxOnShelvesArray count] || [csxOutStockArray count]
        || [csxOffShelvesArray count] || [csxOutDeliveredArray count]) { //员工购有数据
        [sectionArray safeAddObjectsFromArray:csxOnShelvesArray];
        [sectionArray safeAddObjectsFromArray:csxOutStockArray];
        [sectionArray safeAddObjectsFromArray:csxOffShelvesArray];
        if ([csxOutDeliveredArray count]) {
             CartSeparateModel *separate = [[CartSeparateModel alloc]init];
            separate.type                = PTDeliveryEP;
            [sectionArray addObject:separate];
            [sectionArray safeAddObjectsFromArray:csxOutDeliveredArray];
        }
    }else{ //从新排序 当日达正常商品、当日达库存不足、次日达正常商品、次日达库存不足、当日达已下架 、次日达已下架、当日达超出配送、次日达超出配送范围
        [sectionArray safeAddObjectsFromArray:fastOnShelvesArray];
        [sectionArray safeAddObjectsFromArray:fastOutStockArray];
        [sectionArray safeAddObjectsFromArray:slowOnShelvesArray];
        [sectionArray safeAddObjectsFromArray:slowOutStockArray];
        [sectionArray safeAddObjectsFromArray:fastOffShelvesArray];
        [sectionArray safeAddObjectsFromArray:slowOffShelvesArray];
        if ([slowOutDeliveredArray count] || [fastOutDeliveredArray count]) {
            CartSeparateModel *separate = [[CartSeparateModel alloc]init];
            if ([slowOutDeliveredArray count] && [fastOutDeliveredArray count]) {
                separate.type = PTDeliveryUnknown;
            }else if ([slowOutDeliveredArray count]){
                separate.type = PTDeliverySlow;
            }else if ([fastOutDeliveredArray count]){
                separate.type = PTDeliveryFast;
            }
            [sectionArray safeAddObject:separate];
            [sectionArray safeAddObjectsFromArray:fastOutDeliveredArray];
            [sectionArray safeAddObjectsFromArray:slowOutDeliveredArray];
        }

    }
    cartViewData.dataArray     = sectionArray;
    cartViewData.productSort   = spliteElements;
    return cartViewData;
}

@end
