//
//  CartDataHandle.h
//  YHClouds
//
//  Created by 黄小雪 on 16/5/5.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartModelDefine.h"
#import "ShopCartSellerProductModel.h"
@class CartOrderCellViewModel;

@interface CartDataHandle : NSObject
@property (readonly,nonatomic) ShopCartSellerProductModel  *seller;
@property (readonly,nonatomic) BOOL                         isEdit;
@property (assign,nonatomic)   BOOL                         isCSX; //是彩食鲜
//设置section的数据源
-(void)setSellerProduct:(ShopCartSellerProductModel *)sellerProduct
                 isEdit:(BOOL)isEdit;

//调整最后一个cell的底部的线条的长度
-(void)adjustFinalCellBottomLineView;
//排序后的section数据源
-(NSMutableArray *)sortedSellerProducts;

//获取勾选中的商品
-(NSArray *)productSeleted;


//库存不足的个数
-(NSInteger)countOfOutOfStockArr;
//可正常购买的个数
-(NSInteger)countOfNormalArr;
//已下架的个数
-(NSInteger)countOfOffTheShelfArr;
//超出配送范围的个数
-(NSInteger)countOfOutOfDelivered;
//选择去删除的个数
-(NSInteger)countOfSeletedToDeletedArr;
//当前商家的中的所有商品种类数
-(NSInteger)countOfSellerProduct;


//清空删除的商品
-(void)emptyDeleteProducts;
//删除所有选中的商品
-(BOOL)deleteAllSeletedProducts;


//更新所有商品的编辑状态
-(BOOL)upDateAllProductEditState:(BOOL)isEdit;
//更新商品的编辑状态和是否删除状态
-(BOOL)upDateModel:(CartOrderCellViewModel *)vm isEdit:(BOOL)isEdit seletedState:(BOOL)seletedState;
//删除指定商品
-(void)removeProduct:(CartOrderCellViewModel *)model;
@end
