//
//  CartInfoDefine.h
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#ifndef CartInfoDefine_h
#define CartInfoDefine_h

//货物状态
typedef NS_ENUM(NSInteger,ProductShelvesState)
{
    ProductsStateOnShelves = 0,//可购买 优先度3（最低）
    ProductsStateOutStock = 1,//无库存，缺货 优先度2
    ProductsStateOffShelves = 2,//下架 优先度1
    ProductsStateIsOutDelivered = 3,//超出配送范围 优先度0（最高）
};



typedef NS_ENUM(NSInteger,ShopcartEditType)
{
    ShopcartEditTypeNone,       //非编辑模式
    ShopcartEditTypeSeller,     //商家编辑模式
    ShopcartEditTypeAll,        //全部编辑模式
    
};



#endif /* CartInfoDefine_h */
