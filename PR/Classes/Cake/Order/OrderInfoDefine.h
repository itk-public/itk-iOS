//
//  OrderInfoDefine.h
//  PR
//
//  Created by 黄小雪 on 02/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef OrderInfoDefine_h
#define OrderInfoDefine_h

typedef NS_ENUM(NSInteger,OrderFilterType)
{
    OrderFilterTypeAllOrders      = 1,          //查看全部订单
    OrderFilterTypeUnPickUpSelf   = 2,          //待自提
    OrderFilterTypeUnDelivery     = 4,          //待配送
    OrderFilterTypeUnEvaluate     = 6,          //待评价
    OrderFilterTypeRefunding      = 7,          //退款中
};

typedef NS_ENUM(NSInteger,OrderStatus)
{
    OrderStatusToPay  = 1,        //待支付
    OrderStatusPacking,           //商品打包中
    OrderStatusDeliverying,       //配送中
    OrderStatusToPickUp,          //待自提
    OrderStatusComplete,          //订单完成
    OrderStatusCancel,            //订单取消
    OrderStatusRefunding,         //退款审核中
    OrderStatusReturnProducting,  //退货审核中
    OrderStatusRefunded,          //已退款
    OrderStatusReturnProducted,   //已退货
    OrderStatusToDelivery,        //待配送
    
};

typedef NS_ENUM(NSInteger,OrderType)
{
    OrderDeliveryType = 0,     //配送
    OrderPickSelfType,         //自提
};

typedef NS_ENUM(NSInteger,EvaluateType)
{
    EvaluateTypeUnAble      = 0, //不可评价
    EvaluateTypeAble,            //可以评价
    EvaluateTypeAdditional,      //可以追评
};

#endif /* OrderInfoDefine_h */
