//
//  CartOrderCellViewModel.m
//  YHClouds
//
//  Created by 黄小雪 on 16/4/19.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "CartOrderCellViewModel.h"

@implementation CartOrderCellViewModel
-(instancetype)initWithProduct:(ProductOutline *)product
{
    CONDITION_CHECK_RETURN_VAULE([product isKindOfClass:[product class]], nil);
    if (self = [super init]) {
        _product  = product;
        _product.deliverySupportType = PTDeliveryFast;
        _deletedState     = NO;
        
    }
    return self;
}


-(void)setEditType:(ShopcartEditType)editType
{
    _editType = editType;
}

@end
