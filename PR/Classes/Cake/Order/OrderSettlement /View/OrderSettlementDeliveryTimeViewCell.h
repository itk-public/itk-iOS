//
//  OrderSettlementDeliveryTimeViewCell.h
//  PR
//
//  Created by 黄小雪 on 2017/8/21.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "WTTableViewCell.h"
#import "YHDataModel.h"
#import "CouponModel.h"
#import "CKVMDeliveryTimeInfo.h"

@interface OrderSettlementDeliveryTimeViewCellModel : YHDataModel
@property (strong,nonatomic) CKVMDeliveryTimeInfo *timeInfo;
@end

@interface  OrderSettlementCouponModel: YHDataModel
@property (strong,nonatomic) CouponModel *coupon;
@end

@interface OrderSettlementFreightModel : YHDataModel
@property (strong,nonatomic) NSString *freeShipping;

@end


@interface OrderSettlementDeliveryTimeViewCell : WTTableViewCell

@end
