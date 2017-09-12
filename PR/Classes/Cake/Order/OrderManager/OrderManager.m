//
//  OrderManager.m
//  PR
//
//  Created by 黄小雪 on 2017/7/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderManager.h"
#import "OrderListAPIInteract.h"
#import "OrderListModel.h"
#import "OrderSettlementAPIInteract.h"
#import "OrderSubmitAPIInteract.h"

@interface OrderManager()
@property (strong,nonatomic) OrderListAPIInteract *orderListAPI;
@property (strong,nonatomic) OrderListModel *orderList;
@property (strong,nonatomic) OrderSettlementAPIInteract *settlementAPI;
@property (strong,nonatomic) OrderSubmitAPIInteract *submitAPI;

@end
@implementation OrderManager

-(void)orderSubmit:(NSDictionary *)param;
{
    if (self.submitAPI == nil) {
        self.submitAPI = [[OrderSubmitAPIInteract alloc]init];
    }
    [self.submitAPI setParam:param];
    [self.submitAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:OrderManagerTypeOrderSettlement data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:OrderManagerTypeOrderSettlement error:error];
        }
    }];
}


-(void)orderPlace
{
    if (self.settlementAPI == nil) {
        self.settlementAPI = [[OrderSettlementAPIInteract alloc]init];
    }
    [self.settlementAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
            [self.delegate loadDataSuccessful:self dataType:OrderManagerTypeOrderPlace data:modelData isCache:NO];
        }
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:OrderManagerTypeOrderPlace error:error];
        }
    }];
}
-(void)getOrderListFirstPage
{
    [self.orderListAPI interactScuess:^(BaseAPIInteract *interact, id modelData) {
        [self receiveOrderListInfo:modelData];
    } failed:^(BaseAPIInteract *interact, NSError *error, id modelData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:dataType:error:)]) {
            [self.delegate loadDataFailed:self dataType:OrderManagerTypeOrderList error:error];
        }
    }];
}

-(BOOL)getOrderListNextPage
{
    if (![self.orderList hasMore]) {
        return NO;
    }
    [self getOrderListFirstPage];
    return YES;
}


-(void)receiveOrderListInfo:(PartDataResponse *)modelData
{
    //将分页内容load到分页model中
    [self.orderList receiveResponse:modelData];
    
    //通知
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSuccessful:dataType:data:isCache:)]) {
        [self.delegate loadDataSuccessful:self dataType:OrderManagerTypeOrderList data:self.orderList isCache:NO];
    }
}

-(OrderListAPIInteract *)orderListAPI
{
    if (!_orderListAPI) {
        _orderListAPI = [[OrderListAPIInteract alloc]init];
    }
    return _orderListAPI;
}

-(OrderListModel *)orderList
{
    if (!_orderList) {
        _orderList = [[OrderListModel alloc]init];
    }
    return _orderList;
}
@end
