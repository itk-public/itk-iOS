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
FOUNDATION_EXTERN NSString *kSelleridKey;
FOUNDATION_EXTERN NSString *kSelectstateKey;
FOUNDATION_EXTERN NSString *kNumKey;

@interface CartShopDataBaseModel :YHDataModel

@property (readonly,nonatomic) NSString  *pid;
@property (readonly,nonatomic) NSString  *sellerid;
@property (readonly,nonatomic) BOOL      selectstate;
@property (readonly,nonatomic) NSInteger num;

@end
