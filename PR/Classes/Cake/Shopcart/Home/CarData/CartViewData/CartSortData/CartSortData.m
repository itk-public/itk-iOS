//
//  CartSortData.m
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "CartSortData.h"
#import "CartOrderCellViewModel.h"
#import "CartInfoDefine.h"

@implementation CartSortData


//获取排序数据(根据有库存，无库存，已下架排序)
- (NSArray *)sortData:(NSArray *)dataArray
{
    if (dataArray.count == 0) {
        return nil;
    }
    
    NSArray *sortArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        if (![obj1 isKindOfClass:[CartOrderCellViewModel class]] || ![obj2 isKindOfClass:[CartOrderCellViewModel class]]) {
            NSAssert(YES, @"排序model错误 CartOrderCellViewModel...");
        }
        
        CartOrderCellViewModel *model1 = obj1;
        CartOrderCellViewModel *model2 = obj2;
        
        //获取产品上架状态
        ProductShelvesState productShelvesState1 = model1.productsState;
        ProductShelvesState productShelvesState2 = model2.productsState;
        
        //排序顺序根据枚举值来排序（偷懒做法）
        if (productShelvesState1 > productShelvesState2) {
            return NSOrderedDescending ;
        }
        else if (productShelvesState1 < productShelvesState2) {
            return NSOrderedAscending;
        }
        else {
            return NSOrderedSame;
        }
    }];
    return sortArray;
}

@end
