//
//  CartSourceData.h
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  购物车原数据（存储购物车原始数据）

#import <Foundation/Foundation.h>

@class CartViewStructure;

@interface CartSourceData : NSObject
{
    
}
@property (nonatomic,strong,readonly)NSArray *cartSourceModelArray;//存放基本的购物车数据（添加删除购物车数据）
@property (nonatomic,strong,readonly)NSArray *cartSourceDataArray;//原始数据

+ (instancetype)shareInstance;

#pragma mark ---------------------数据获取----------------------

/**
 根据传入的构造器，返回对应的页面数据

 @param structure 数据构造器

 @return 页面数据NSArray
 */
- (NSArray *)acquireDataArray:(CartViewStructure *)structure;


@end
