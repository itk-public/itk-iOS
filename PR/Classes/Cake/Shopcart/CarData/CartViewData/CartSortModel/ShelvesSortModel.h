//
//  ShelvesSortModel.h
//  YHClouds
//
//  Created by youjunjie on 14/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  根据不同的商品状态，分类数组

#import <Foundation/Foundation.h>
#import "CartInfoDefine.h"

@interface ShelvesSortModel : NSObject
{
    
}
@property (nonatomic,assign)ProductShelvesState shelvesStates;//商品状态
@property (nonatomic,strong)NSArray *productsArray;//商品数组

+ (instancetype)initWithArray:(NSArray *)array;

@end
