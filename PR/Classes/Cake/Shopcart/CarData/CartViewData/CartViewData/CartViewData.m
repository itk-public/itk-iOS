//
//  CartViewData.m
//  YHClouds
//
//  Created by youjunjie on 17/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "CartViewData.h"
#import "CartOrderCellViewModel.h"
@implementation CartViewData
-(NSInteger)countOfOutOfDeliveredWithType:(PTDeliveryType)type
{
    NSArray *products = [self.productSort acquireDataOfCategory:type shelvesState:ProductsStateIsOutDelivered];
    if (products) {
        return [products count];
    }
    return 0;
}
@end
