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
@property (nonatomic, strong) NSArray *productsArr;
@property (nonatomic, copy  ) NSString *uid;
// 1: 自提  2: 配送
@property (nonatomic, assign) BOOL     isPickself;
@end
