//
//  CartSectionData.h
//  YHClouds
//
//  Created by 黄小雪 on 16/8/15.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCartSellerProductModel.h"
#import "CartDataHandle.h"
#import "ShopDescInfo.h"

@interface CartSectionData : NSObject

-(void)setSellerProducts:(ShopCartSellerProductModel *)sellerProducts;

//是否在编辑状态
@property (assign,nonatomic ) ShopcartEditType               editType;
@property (copy,nonatomic)    NSString                      *sellerid;

//排序后的section数据源
@property (strong,nonatomic ) NSArray                        *sortedSellerProducts;
@property (readonly,nonatomic) CartDataHandle                *dataHandle;
@property (readonly,nonatomic) ShopCartSellerProductModel    *sellerProductModel;

@end
