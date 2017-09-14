//
//  ConsumptionDetailModel.h
//  PR
//
//  Created by 黄小雪 on 2017/9/13.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"

typedef NS_ENUM(NSInteger,ConsumptionDetailModelType)
{
    ConsumptionDetailModelTypeConsumption = 0,  //消费
    ConsumptionDetailModelTypeRefund,           //退款
};

@interface ConsumptionDetailModel : YHDataModel
@property (assign,nonatomic) ConsumptionDetailModelType type;
@property (strong,nonatomic) NSString *dateStr;
@property (strong,nonatomic) NSString *moneyStr;

@end
