//
//  CommitErrorHandler.h
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/27.
//  Copyright © 2017年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopcartFormat.h"

@interface CommitErrorHandler : NSObject
+(void)hanlerWitherror:(NSError*)error data:(id)data;

//下架或者库存不足的商品
-(void)outStockOrOffShelveWithData:(id)data error:(NSError*)error;
@property (weak,nonatomic) ShopcartFormat *holder;
@end
