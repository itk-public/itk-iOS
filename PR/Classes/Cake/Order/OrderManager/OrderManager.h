//
//  OrderManager.h
//  PR
//
//  Created by 黄小雪 on 2017/7/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderManager;

typedef NS_ENUM(NSInteger,OrderManagerType)
{
    OrderManagerTypeOrderList = 0,        //订单列表
    OrderManagerTypeOrderPlace,           //购物车到订单结算
    OrderManagerTypeOrderSettlement,      //订单结算页的，提交订单
    OrderManagerTypeOrderDetail,          //订单详情
};

@protocol OrderMangerDelegate <NSObject>
-(void)loadDataSuccessful:(OrderManager *)manager dataType:(OrderManagerType)dataType  data:(id)data  isCache:(BOOL)isCache;
-(void)loadDataFailed:(OrderManager *)manager dataType:(OrderManagerType )dataType error:(NSError*)error;
@end


@interface OrderManager : NSObject
@property (weak,nonatomic) id<OrderMangerDelegate> delegate;

//获取第一页我的订单列表
-(void)getOrderListFirstPage;

//获取下一页的订单列表
-(BOOL)getOrderListNextPage;

-(void)orderPlace;

//订单结算
-(void)orderSubmit:(NSDictionary *)param;

//订单详情
-(void)orderDetail:(NSString *)orderId;
@end
