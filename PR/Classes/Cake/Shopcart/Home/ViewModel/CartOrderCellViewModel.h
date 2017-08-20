//
//  CartOrderCellViewModel.h
//  YHClouds
//
//  Created by 黄小雪 on 16/4/19.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOutline.h"
#import "CartInfoDefine.h"

@interface CartOrderCellViewModel : NSObject
-(instancetype)initWithProduct:(ProductOutline*)product;

@property (strong,nonatomic) ProductOutline *product;
@property (assign,nonatomic) BOOL deletedState;
@property (assign,nonatomic) ShopcartEditType editType;
@property (assign,nonatomic) BOOL bottomLineHide;
@property (nonatomic,assign)ProductShelvesState productsState;

@end
