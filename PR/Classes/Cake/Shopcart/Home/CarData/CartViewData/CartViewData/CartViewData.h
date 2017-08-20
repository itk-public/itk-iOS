//
//  CartViewData.h
//  YHClouds
//
//  Created by youjunjie on 17/10/2016.
//  Copyright © 2016 YH. All rights reserved.
//  页面数据

#import <Foundation/Foundation.h>
#import "ProductSortElements.h"

@interface CartViewData : NSObject
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) ProductSortElements *productSort;
-(NSInteger)countOfOutOfDeliveredWithType:(PTDeliveryType)type;
@end
