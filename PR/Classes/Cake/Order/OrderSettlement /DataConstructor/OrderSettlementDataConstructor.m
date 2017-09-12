//
//  OrderSettlementDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/8/23.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderSettlementDataConstructor.h"
#import "OrderManager.h"
#import "OrderDetail.h"
#import "OrderSettlementDeliveryTimeViewCell.h"
#import "OrderSettlementRemarkViewCell.h"
#import "OrderSettlementProductViewCell.h"
#import "OrderSettlementPriceDetailViewCell.h"
#import "SeparateCell.h"
#import "CKVMDeliveryTimeInfo.h"
#import "OrderSettlementSaveBtnCell.h"

@interface OrderSettlementDataConstructor()<OrderMangerDelegate>
@property (strong,nonatomic) OrderManager *manager;
@property (strong,nonatomic) OrderDetail  *orderDetail;
@end

@implementation OrderSettlementDataConstructor
-(void)loadData
{
    [self.manager orderPlace];
}

-(void)constructData
{
    if (self.orderDetail) {
        [self.items removeAllObjects];
        
        //分割cell
        SeparateModel *separate1 = [[SeparateModel alloc]init];
        separate1.cellIdentifier = @"SeparateCell";
        separate1.cellClass      = [SeparateCell class];
        [self.items addObject:separate1];
        
        //配送时间
        if (self.orderDetail.deliveryTimeInfo && [self.orderDetail.deliveryTimeInfo count]) {
            OrderSettlementDeliveryTimeViewCellModel *orderTimeModel = [[OrderSettlementDeliveryTimeViewCellModel alloc]init];
            orderTimeModel.cellClass = [OrderSettlementDeliveryTimeViewCell class];
            orderTimeModel.cellIdentifier = @"OrderSettlementDeliveryTimeViewCell";
            CKVMDeliveryTimeInfo *timeInfo = [[CKVMDeliveryTimeInfo alloc]initWithDelivertTimeInfo:self.orderDetail.deliveryTimeInfo];
            orderTimeModel.timeInfo         = timeInfo;
            [self.items addObject:orderTimeModel];
        }
       
        
        //优惠券
        if (self.orderDetail.coupon) {
            OrderSettlementCouponModel *couponModel = [[OrderSettlementCouponModel alloc]init];
            couponModel.cellClass = [OrderSettlementDeliveryTimeViewCell class];
            couponModel.coupon    = self.orderDetail.coupon;
            couponModel.cellIdentifier = @"OrderSettlementDeliveryTimeViewCell";
            [self.items addObject:couponModel];
        }
        
        //运费
        if (self.orderDetail.freeShipping) {
            OrderSettlementFreightModel *freightModel = [[OrderSettlementFreightModel alloc]init];
            freightModel.cellClass = [OrderSettlementDeliveryTimeViewCell class];
            freightModel.cellIdentifier = @"OrderSettlementDeliveryTimeViewCell";
            freightModel.freeShipping   = self.orderDetail.freeShipping;
            [self.items addObject:freightModel];
        }
        
        
        
        //分割cell
        SeparateModel *separate2 = [[SeparateModel alloc]init];
        separate2.cellIdentifier = @"SeparateCell";
        separate2.cellClass      = [SeparateCell class];
        [self.items addObject:separate2];
        
        //备注
        OrderSettlementRemarkViewCellModel *remarkModel = [[OrderSettlementRemarkViewCellModel alloc]init];
        remarkModel.cellIdentifier   = @"OrderSettlementRemarkViewCell";
        remarkModel.cellClass        = [OrderSettlementRemarkViewCell class];
        [self.items addObject:remarkModel];
        
        //分割cell
        SeparateModel *separate3 = [[SeparateModel alloc]init];
        separate3.cellIdentifier = @"SeparateCell";
        separate3.cellClass      = [SeparateCell class];
        [self.items addObject:separate3];
        
        //商品
        for(ProductOutline *product in self.orderDetail.proudcts){
            if ([product isKindOfClass:[ProductOutline class]]) {
                product.cellClass = [OrderSettlementProductViewCell class];
                product.cellIdentifier = @"OrderSettlementProductViewCell";
                [self.items addObject:product];
            }
        }
        
        //分割cell
        SeparateModel *separate4 = [[SeparateModel alloc]init];
        separate4.cellIdentifier = @"SeparateCell";
        separate4.cellClass      = [SeparateCell class];
        [self.items addObject:separate4];
        
        //价格详情
        OrderSettlementPriceDetailViewCellModel *priceModel = [[OrderSettlementPriceDetailViewCellModel alloc]init];
        priceModel.cellIdentifier = @"OrderSettlementPriceDetailViewCell";
        priceModel.cellClass      = [OrderSettlementPriceDetailViewCell class];
        priceModel.priceTotal     = self.orderDetail.priceTotal;
        priceModel.totalPayment   = self.orderDetail.totalPayment;
        priceModel.discount       = self.orderDetail.discount;
        priceModel.freight        = self.orderDetail.freight;
        [self.items addObject:priceModel];
        
        //saveBtn
        OrderSettlementSaveBtnCellModel *saveBtnModel = [[OrderSettlementSaveBtnCellModel alloc]init];
        saveBtnModel.cellClass = [OrderSettlementSaveBtnCell class];
        saveBtnModel.cellIdentifier = @"OrderSettlementSaveBtnCell";
        saveBtnModel.cellSelResponse = self.responder;
        [self.items addObject:saveBtnModel];
        
        
    }
}

-(OrderManager *)manager
{
    if (_manager == nil) {
        _manager = [[OrderManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

#pragma mark OrderManagerDelegate
-(void)loadDataSuccessful:(OrderManager *)manager dataType:(OrderManagerType)dataType  data:(id)data  isCache:(BOOL)isCache;
{
    if ([data isKindOfClass:[OrderDetail class]]) {
        self.orderDetail = data;
        if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
            [self.delegate dataConstructor:self didFinishLoad:data];
        }
    }
}


-(void)loadDataFailed:(OrderManager *)manager dataType:(OrderManagerType )dataType error:(NSError*)error;
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}

@end
