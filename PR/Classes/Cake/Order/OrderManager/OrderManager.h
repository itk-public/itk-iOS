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
    OrderManagerTypeOrderList = 0,
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
@end
