//
//  CSXCartCellDefine.h
//  YHClouds
//
//  Created by 黄小雪 on 16/10/19.
//  Copyright © 2016年 YH. All rights reserved.
//

#ifndef CSXCartCellDefine_h
#define CSXCartCellDefine_h
#import "NSObject+MSignal.h"

typedef NS_ENUM (NSInteger,CartCellType)
{
    CartCellCSXSoryType = 9001,
    CartCellCSXSProductType,
    CartCellCSXSSeparateType,
    FastLoactionCategoryType
};


typedef NS_ENUM(NSInteger,BtnTag)
{
    BtnTagSeleted   = 1,
    BtnTagArrow,
    BtnTagChange,
    BtnTagEdit,
    
    BtnTypeCommit,    //结算
    BtnTypeDeleted,     //删除
    BtnTypeIllegal,
};


//切换地址
msignal(CartChangeAddressSignal);

//商品的勾选
msignal(CartChangeProductSeletedStateSignal);

//全选的勾选
msignal(CartChangeProductAllSeletedStateSignal);

//删除商品
msignal(CartDelegateProductSignal);

//显示修改商品数量的alter
msignal(CartShowNumControlSignal);

//修改商品数量
msignal(CartChangeProductNumSignal);





#endif /* CSXCartCellDefine_h */
