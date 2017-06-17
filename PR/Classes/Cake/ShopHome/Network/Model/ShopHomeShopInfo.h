//
//  ShopHomeShopInfo.h
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopDescInfo.h"

@interface ShopHomeShopInfo : ShopDescInfo
@property (readonly,nonatomic) NSInteger score;
@property (readonly,nonatomic) NSInteger attentionNum;
@property (readonly,nonatomic) BOOL      isAttention;
@end
