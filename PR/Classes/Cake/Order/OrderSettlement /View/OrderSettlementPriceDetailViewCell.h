//
//  OrderSettlementPriceDetailViewCell.h
//  PR
//
//  Created by 黄小雪 on 2017/8/21.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"

@interface OrderSettlementPriceDetailViewCellModel : YHDataModel
//运费
@property (strong,nonatomic) NSString *freight;
//总计1
@property (strong,nonatomic) NSString *priceTotal;
//优惠
@property (strong,nonatomic) NSString *discount;
//总计2
@property (strong,nonatomic) NSString *totalPayment;

@end
@interface OrderSettlementPriceDetailViewCell : WTTableViewCell

@end
