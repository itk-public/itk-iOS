//
//  CartSourceModel.h
//  YHClouds
//
//  Created by youjunjie on 17/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  购物车存储model，只存放必须的数据

#import <Foundation/Foundation.h>

@interface CartSourceModel : NSObject

@property (nullable, nonatomic, copy) NSString *cid;//商品ID
@property (nullable, nonatomic, copy) NSString *merid;//商家ID
@property (nullable, nonatomic, copy) NSNumber *num;//商品数量
@property (nullable, nonatomic, copy) NSNumber *selectstate;//是否勾选
@property (nullable, nonatomic, copy) NSString *stacktitle;//记录购买路径title
@property (nullable, nonatomic, copy) NSString *updatetime;//添加时间

@property (nullable, nonatomic, copy) NSNumber *stocknum;//库存
@property (nullable, nonatomic, copy) NSString *price;//商品价格





@end
