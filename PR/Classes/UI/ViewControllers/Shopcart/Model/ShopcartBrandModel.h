//
//  ShopcartBrandModel.h
//  PR
//
//  Created by 黄小雪 on 2017/4/6.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInfo.h"

@interface ShopcartBrandModel : NSObject

@property (copy,nonatomic) NSString *shopId;
@property (strong,nonatomic) NSMutableArray<ProductInfo *> *products;
@property (nonatomic, assign)BOOL isSelected; //记录相应section是否全选（自定义）
@property (nonatomic, strong) NSMutableArray *selectedArray;    //结算时筛选出选中的商品（自定义）


@end
