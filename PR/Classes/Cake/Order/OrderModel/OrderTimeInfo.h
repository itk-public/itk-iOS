//
//  OrderTimeInfo.h
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

@interface OrderTimeInfo : YHDataModel
//下单时间
@property (readonly,nonatomic) NSString *generateTime;
//支付时间（若未支付为空）
@property (readonly,nonatomic) NSString *payTime;
//拣货完成时间
@property (readonly,nonatomic) NSString *pickTime;
//配送完成时间
@property (readonly,nonatomic) NSString *deliveryTime;
//订单完成时间
@property (readonly,nonatomic) NSString *completedTime;
//取消时间
@property (readonly,nonatomic) NSString *canceledTime;
//支付截至时间
@property (readonly,nonatomic) NSString *payendTime;
@end
