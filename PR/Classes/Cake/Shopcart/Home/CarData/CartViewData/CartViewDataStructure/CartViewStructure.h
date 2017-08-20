//
//  CartViewStructure.h
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  购物车页面数据构造器

#import <Foundation/Foundation.h>
#import "CartViewData.h"

@interface CartViewStructure : NSObject


/**
 传入请求到的数据,返回页面数据
 
 @param originalProductArray 请求数据
 
 @return 页面数据
 */
- (CartViewData *)viewDataArray:(NSArray *)originalProductArray;

@end
