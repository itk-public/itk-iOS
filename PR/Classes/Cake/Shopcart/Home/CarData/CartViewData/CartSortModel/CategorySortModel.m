//
//  CategorySortModel.m
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "CategorySortModel.h"
#import "CartOrderCellViewModel.h"
#import "ProductOutline.h"
#import "ShelvesSortModel.h"
#import "CartInfoDefine.h"

@implementation CategorySortModel

/**
 获取库存状态
 
 @param isOutOfStock   YES:库存不足; NO:库存足
 @param isOffTheShelf YES:下架; NO:上架
 
 @return ProductShelvesState
 */
- (ProductShelvesState)productShelvesState:(BOOL)isOutOfStock isOffTheShelf:(BOOL)isOffTheShelf isOutDelivered:(BOOL)isOutDelivered
{
    //先判断是否超出配送范围
    if (isOutDelivered) {
        return ProductsStateIsOutDelivered;
    }
    
    if (!isOutOfStock && !isOffTheShelf) {
        return ProductsStateOnShelves;
    }
    else if (isOffTheShelf) {
        return ProductsStateOffShelves;
    }
    else if (isOutOfStock) {
        return ProductsStateOutStock;
    }
    return ProductsStateOffShelves;
}


+ (instancetype)initWithArray:(NSArray *)array
{
    CategorySortModel *categorySortModel = [[CategorySortModel alloc]init];
    
    if (!array || array.count == 0) {
        return categorySortModel;
    }
    
    NSMutableArray *onShelvesArray = [[NSMutableArray alloc]init];
    NSMutableArray *outStockArray = [[NSMutableArray alloc]init];
    NSMutableArray *offShelvesArray = [[NSMutableArray alloc]init];
    NSMutableArray *isOutDeliveredArray = [[NSMutableArray alloc]init];
    
    for (CartOrderCellViewModel *cartOrderCellViewModel in array) {
        
        //获取产品上架状态
        ProductShelvesState productShelvesState = [categorySortModel productShelvesState:cartOrderCellViewModel.product.isOutOfStock isOffTheShelf:cartOrderCellViewModel.product.isOffTheShelf isOutDelivered:cartOrderCellViewModel.product.isOutDelivered];
        cartOrderCellViewModel.productsState = productShelvesState;
        
        if (cartOrderCellViewModel.productsState == ProductsStateIsOutDelivered) {
            
            [isOutDeliveredArray addObject:cartOrderCellViewModel];
        }
        else if (cartOrderCellViewModel.productsState == ProductsStateOnShelves) {
            
            [onShelvesArray addObject:cartOrderCellViewModel];
        }
        else if (cartOrderCellViewModel.productsState == ProductsStateOutStock)
        {
            [outStockArray addObject:cartOrderCellViewModel];
        }
        else if (cartOrderCellViewModel.productsState == ProductsStateOffShelves)
        {
            [offShelvesArray addObject:cartOrderCellViewModel];
        }
    }
    //超出配送范围
    ShelvesSortModel *isOutDeliveredSortModel = [ShelvesSortModel initWithArray:isOutDeliveredArray];
    isOutDeliveredSortModel.shelvesStates = ProductsStateIsOutDelivered;
    
    ShelvesSortModel *onShelvesSortModel = [ShelvesSortModel initWithArray:onShelvesArray];
    onShelvesSortModel.shelvesStates = ProductsStateOnShelves;
    
    ShelvesSortModel *outStockSortModel = [ShelvesSortModel initWithArray:outStockArray];
    outStockSortModel.shelvesStates = ProductsStateOutStock;
    
    ShelvesSortModel *offShelvesSortModel = [ShelvesSortModel initWithArray:offShelvesArray];
    offShelvesSortModel.shelvesStates = ProductsStateOffShelves;
    
    NSArray *shelvesSortArray = [NSArray arrayWithObjects:onShelvesSortModel,outStockSortModel,offShelvesSortModel,isOutDeliveredSortModel, nil];
    categorySortModel.shelvesSortArray = shelvesSortArray;
    
    return categorySortModel;
}

@end
