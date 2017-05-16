//
//  CartShopDataBaseModel.h
//  PR
//
//  Created by 黄小雪 on 27/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHDataModel.h"

FOUNDATION_EXTERN NSString *kPidKey;
FOUNDATION_EXTERN NSString *kShopIdKey;
FOUNDATION_EXTERN NSString *kIsSelectedKey;
FOUNDATION_EXTERN NSString *kNumKey;

@interface CartShopDataBaseModel :YHDataModel

@property (readonly,nonatomic) NSString  *cid;
@property (readonly,nonatomic) NSString  *shopId;
@property (readonly,nonatomic) BOOL      isSelected;
@property (readonly,nonatomic) NSInteger num;

@end
