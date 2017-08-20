//
//  CartSortData.h
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  购物车数据排序

#import <Foundation/Foundation.h>


@interface CartSortData : NSObject

//获取排序数据(根据有库存，无库存，已下架排序)
- (NSArray *)sortData:(NSArray *)dataArray;


@end
