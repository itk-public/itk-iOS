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

#endif /* OrderInfoDefine_h */
