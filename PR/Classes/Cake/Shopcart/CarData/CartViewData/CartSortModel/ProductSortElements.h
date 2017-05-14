//
//  ProductSortElements.h
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  把数据拆分为小零件，根据需求提供给页面

#import <Foundation/Foundation.h>
#import "CartModelDefine.h"
#import "CartInfoDefine.h"



@interface ProductSortElements : NSObject

@property (nonatomic,strong)NSArray *elementsArray;//元素数组  里面按当日达、次日达存放，类别里面按照上架状态存放

/**
 拆分数据
 
 @param array array
 */
- (void)splitElementsArray:(NSArray *)originalProductArray;

#pragma mark ---------------------到家的数据获取方法----------------------
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

#pragma mark ---------------------彩食鲜的数据获取方法----------------------


/**
 获取所有的类别ID (CSXCartCategoryModel)

 @return NSArray <CSXCartCategoryModel>
 */
- (NSArray *)allCSXCategoryID;


/**
 获取对应类别，对应上架状态的model

 @param category     类别model
 @param shelvesState NSArray

 @return NSArray
 */
- (NSArray *)acquireCSXDataOfCategoryID:(NSString *)categoryID shelvesState:(ProductShelvesState)shelvesState;


/**
 获取该model里的上架状况

 @param shelvesState <#shelvesState description#>

 @return <#return value description#>
 */
- (NSInteger)countOfCSXShelvesState:(ProductShelvesState)shelvesState;

@end
