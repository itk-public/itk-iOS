//
//  OrderDetail.h
//  PR
//
//  Created by 黄小雪 on 2017/7/1.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "YHDataModel.h"
#import "OrderInfoDefine.h"
#import "OrderTimeInfo.h"
#import "Action.h"
#import "ShopDescInfo.h"
#import "ProductOutline.h"
#import "OrderPriceDetail.h"

@interface OrderDetail : YHDataModel
//订单id
@property (readonly,nonatomic) NSString *cid;
//订单类型
@property (readonly,nonatomic) OrderType orderType;
//订单状态
@property (readonly,nonatomic) OrderStatus orderStauts;
//订单标题
@property (readonly,nonatomic) NSString *title;
//订单的各个时间节点
@property (readonly,nonatomic) OrderTimeInfo *timeInfo;
//订单自提码
@property (readonly,nonatomic) NSString *pickSelfCode;
//订单包含的商品
@property (readonly,nonatomic) NSArray<ProductOutline *> *proudcts;
//订单调整链接
@property (readonly,nonatomic) Action *action;
//是否可以退款退货
@property (readonly,nonatomic) BOOL isRefundable;
//订单备注
@property (readonly,nonatomic) NSString *remark;
//店铺信息
@property (readonly,nonatomic) ShopDescInfo *shopInfo;
//订单总计
@property (readonly,nonatomic) NSString *totalPayment;
//评价类型
@property (readonly,nonatomic) EvaluateType  evalutateType;
//价格信息
@property (readonly,nonatomic) OrderPriceDetail *priceDetail;

@end
