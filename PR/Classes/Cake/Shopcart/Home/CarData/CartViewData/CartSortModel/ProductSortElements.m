//
//  ProductSortElements.m
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "ProductSortElements.h"


@implementation ProductSortElements

/**
 拆分数据
 
 @param array array
 */
- (void)splitElementsArray:(NSArray *)originalProductArray
{
    
}

#pragma mark ---------------------到家的数据获取方法----------------------
/**
 根据不同分类，获取数据
 
 @param deliveryType 当日达，次日达
 @param shelvesState 上架状态
 
 @return <#return value description#>
 */
- (NSArray *)acquireDataOfCategory:(PTDeliveryType)deliveryType shelvesState:(ProductShelvesState)shelvesState {
    
    return nil;
}


/**
 返回类别下某上架情况的数量
 
 @param deliveryType 当日达，次日达
 @param shelvesState 上架状态
 
 @return 商品数量
 */
- (NSInteger)countOfCategory:(PTDeliveryType)deliveryType shelvesState:(ProductShelvesState)shelvesState {
    
    return 0;
}


/**
 根据当日达，次日达获取数据
 
 @param deliveryType 当日达，次日达
 
 @return 上架状态
 */
- (NSArray *)acquireDataOfCategory:(PTDeliveryType)deliveryType {
    
    return nil;
}


/**
 根据类别(当日达，次日达)获取该类别下商品数量
 
 @param deliveryType 当日达，次日达
 
 @return 商品数量
 */
- (NSInteger)countOfCategory:(PTDeliveryType)deliveryType{
    
    return 0;
}


#pragma mark ---------------------彩食鲜的数据获取方法----------------------

/**
 获取所有的类别ID (CSXCartCategoryModel)
 
 @return NSArray <CSXCartCategoryModel>
 */
- (NSArray *)allCSXCategoryID {
    return nil;
}


/**
 获取对应类别，对应上架状态的model
 
 @param category     类别model
 @param shelvesState NSArray
 
 @return NSArray
 */
- (NSArray *)acquireCSXDataOfCategoryID:(NSString *)categoryID shelvesState:(ProductShelvesState)shelvesState {
    return nil;
}


/**
 获取该model里的上架状况
 
 @param shelvesState <#shelvesState description#>
 
 @return <#return value description#>
 */
- (NSInteger)countOfCSXShelvesState:(ProductShelvesState)shelvesState {
    return 0;
}

@end
