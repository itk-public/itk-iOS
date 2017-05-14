//
//  RefreshCartAPIInteract.h
//  YHClouds
//
//  Created by 黄小雪 on 15/10/26.
//  Copyright © 2015年 YH. All rights reserved.
//

#import "BaseAPIInteract.h"
#import "CartModelDefine.h"

@interface RefreshCartAPIInteract : BaseAPIInteract
/**
 *  本地的快照数组或者是选中的商品Arr
 */
@property (nonatomic, strong) NSArray *productsArr;
/**
 *  用户id
 */
@property (nonatomic, copy  ) NSString *uid;

// 1: 自提  2: 配送
@property (nonatomic, assign) BOOL     isPickself;

@property (nonatomic, assign) BOOL     isSelected;

@end
