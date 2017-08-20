//
//  DJProductSortElements.h
//  YHClouds
//
//  Created by youjunjie on 19/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  把数据拆分为小零件，根据需求提供给页面（到家）

#import "ProductSortElements.h"

@interface DJProductSortElements : ProductSortElements

/**
 拆分数据
 
 @param array array
 */
- (void)splitElementsArray:(NSArray *)originalProductArray;


/**
 根据不同分类，获取数据
 
 @param deliveryType 当日达，次日达
 @param shelvesState 上架状态
 
 @return <#return value description#>
 */
- (NSArray *)acquireDataOfCategory:(PTDeliveryType)deliveryType shelvesState:(ProductShelvesState)shelvesState;


/**
 返回类别下某上架情况的数量
 
 @param deliveryType 当日达，次日达
 @param shelvesState 上架状态
 
 @return 商品数量
 */
- (NSInteger)countOfCategory:(PTDeliveryType)deliveryType shelvesState:(ProductShelvesState)shelvesState;


/**
 根据当日达，次日达获取数据
 
 @param deliveryType 当日达，次日达
 
 @return 上架状态
 */
- (NSArray *)acquireDataOfCategory:(PTDeliveryType)deliveryType;


/**
 根据类别(当日达，次日达)获取该类别下商品数量
 
 @param deliveryType 当日达，次日达
 
 @return 商品数量
 */
- (NSInteger)countOfCategory:(PTDeliveryType)deliveryType;

@end
