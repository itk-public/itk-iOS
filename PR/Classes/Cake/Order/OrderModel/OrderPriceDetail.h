//
//  OrderPriceDetail.h
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@interface OrderPriceDetail : YHDataModel
@property (readonly,nonatomic) NSInteger totalAmount;

- (void)updatePriceInfo:(NSDictionary *)dict;
- (NSString *)totalPriceDes;
@end
