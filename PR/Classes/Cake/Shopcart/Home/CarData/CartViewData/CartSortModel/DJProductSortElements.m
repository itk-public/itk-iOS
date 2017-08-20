//
//  DJProductSortElements.m
//  YHClouds
//
//  Created by youjunjie on 19/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "DJProductSortElements.h"

#import "CartSortData.h"
#import "CartOrderCellViewModel.h"
#import "CategorySortModel.h"
#import "ShelvesSortModel.h"

@implementation DJProductSortElements
@synthesize elementsArray = _elementsArray;

/**
 拆分数据
 
 @param array array
 */
- (void)splitElementsArray:(NSArray *)originalProductArray {
    
    if (!originalProductArray || originalProductArray.count == 0) {
        return;
    }
    
    //根据当日达、次日达、彩食鲜分类
    NSMutableArray *fastCategorySortModelArray = [[NSMutableArray alloc]init];
    NSMutableArray *slowCategorySortModelArray = [[NSMutableArray alloc]init];
    NSMutableArray *csxCategorySortModelArray = [[NSMutableArray alloc]init];
    for (CartOrderCellViewModel *cartOrderCellViewModel in originalProductArray) {
        
//        if (cartOrderCellViewModel.product.deliverySupportType == PTDeliveryFast) {
//            
//            [fastCategorySortModelArray addObject:cartOrderCellViewModel];
//        }
//        else if (cartOrderCellViewModel.product.deliverySupportType == PTDeliverySlow)
//        {
//            [slowCategorySortModelArray addObject:cartOrderCellViewModel];
//        }
//        else if (cartOrderCellViewModel.product.deliverySupportType == PTDeliveryEP)
//        {
//            [csxCategorySortModelArray addObject:cartOrderCellViewModel];
//        }
    }
    
    //对每个类别里面再次分类为
    CategorySortModel *fastCategorySortModel = [CategorySortModel initWithArray:fastCategorySortModelArray];
    fastCategorySortModel.deliveryType = PTDeliveryFast;
    
    CategorySortModel *slowCategorySortModel = [CategorySortModel initWithArray:slowCategorySortModelArray];
    slowCategorySortModel.deliveryType = PTDeliverySlow;
    
    CategorySortModel *csxCategorySortModel = [CategorySortModel initWithArray:csxCategorySortModelArray];
    csxCategorySortModel.deliveryType = PTDeliveryEP;
    
    //加入元素
    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithObjects:fastCategorySortModel,slowCategorySortModel,csxCategorySortModel, nil];
    self.elementsArray = [NSArray arrayWithArray:mutableArray];
}


/**
 根据不同分类，获取数据
 
 @param deliveryType 当日达，次日达
 @param shelvesState 上架状态
 
 @return <#return value description#>
 */
- (NSArray *)acquireDataOfCategory:(PTDeliveryType)deliveryType
                      shelvesState:(ProductShelvesState)shelvesState
{
    NSArray *array = [NSArray array];
    if (_elementsArray && _elementsArray.count > 0) {
        
        //先获取对应的类别(当日达、次日达)
        for (CategorySortModel *categoryModel in _elementsArray) {
            
            //找到了对应的类别
            if (categoryModel.deliveryType == deliveryType) {
                
                if (categoryModel.shelvesSortArray && categoryModel.shelvesSortArray.count > 0) {
                    
                    for (ShelvesSortModel *shelvesModel in categoryModel.shelvesSortArray) {
                        
                        if (shelvesModel.shelvesStates == shelvesState) {
                            
                            return shelvesModel.productsArray;
                        }
                    }
                }
            }
        }
    }
    
    return  array;
}

/**
 返回类别下某上架情况的数量
 
 @param deliveryType 当日达，次日达
 @param shelvesState 上架状态
 
 @return 商品数量
 */
- (NSInteger)countOfCategory:(PTDeliveryType)deliveryType shelvesState:(ProductShelvesState)shelvesState {
    
    NSInteger count = 0;
    
    NSArray *array = [self acquireDataOfCategory:deliveryType shelvesState:shelvesState];
    
    if (array) {
        
        return array.count;
    }
    
    return count;
}

/**
 根据当日达，次日达获取数据
 
 @param deliveryType 当日达，次日达
 
 @return 上架状态
 */
- (NSArray *)acquireDataOfCategory:(PTDeliveryType)deliveryType
{
    NSArray *array = [NSArray array];
    
    if (_elementsArray && _elementsArray.count > 0) {
        
        //先获取对应的类别(当日达、次日达)
        for (CategorySortModel *categoryModel in _elementsArray) {
            
            if (categoryModel.deliveryType == deliveryType) {
                
                NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
                
                if (categoryModel.shelvesSortArray && categoryModel.shelvesSortArray.count > 0) {
                    
                    //找对应的上架方式
                    for (ShelvesSortModel *shelvesModel in categoryModel.shelvesSortArray) {
                        
                        [mutableArray safeAddObjectsFromArray:shelvesModel.productsArray];
                    }
                }
                
                return mutableArray;
            }
        }
    }
    
    return  array;
}

/**
 根据类别(当日达，次日达)获取该类别下商品数量
 
 @param deliveryType 当日达，次日达
 
 @return 商品数量
 */
- (NSInteger)countOfCategory:(PTDeliveryType)deliveryType
{
    NSInteger count = 0;
    
    NSArray *array = [self acquireDataOfCategory:deliveryType];
    
    if (array) {
        
        return array.count;
    }
    
    return count;
}

@end
