//
//  CartUpdateData.h
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  购物车数据更新操作

#import <Foundation/Foundation.h>

@interface CartUpdateData : NSObject

//清空购物车数据
- (BOOL)clearCart;

//删除购物车数据
- (BOOL)deleteCartData:(NSArray *)dataArray;

//更新购物车数据
- (BOOL)updateCartData:(NSArray *)dataArray;

//插入购物车数据
- (BOOL)insertCarData:(NSArray *)dataArray;

@end
