//
//  OrderDetailDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 05/03/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "OrderDetailDataConstructor.h"
#import "ShopInfoViewCell.h"
#import "OrderDetailProductViewCell.h"
#import "SeparateCell.h"
#import "PromptViewCell.h"
#import "OrderDetailActionViewCell.h"
#import "DeliveryAddressViewCell.h"
#import "OrderStatusFlowViewCell.h"


#import "YHDataModel.h"
#import "OrderManager.h"
#import "OrderDetail.h"

@interface TestModel :YHDataModel

@end

@implementation TestModel

@end

@interface OrderDetailDataConstructor()<OrderMangerDelegate>
@property (strong,nonatomic) OrderManager *manager;
@property (strong,nonatomic) OrderDetail  *orderDetail;

@end
@implementation OrderDetailDataConstructor

-(void)loadData
{
    if (self.manager == nil) {
        self.manager = [[OrderManager alloc]init];
        self.manager.delegate = self;
    }
    [self.manager orderDetail:nil];
}

-(void)constructData
{
    if (self.orderDetail) {
        [self.items removeAllObjects];
        
        //订单状态
        OrderStatusFlowViewCellModel *flowModel = [[OrderStatusFlowViewCellModel alloc]init];
        flowModel.cellClass    = [OrderStatusFlowViewCell class];
        flowModel.cellIdentifier     = @"OrderStatusFlowViewCell";
        [self.items addObject:flowModel];

        //分割cell
        SeparateModel *model14 = [[SeparateModel alloc]init];
        model14.cellIdentifier = @"sparatemodel";
        model14.cellClass = [SeparateCell class];
        [self.items addObject:model14];
        
        //地址cell
        DeliveryAddressViewCellModel *addressModel = [[DeliveryAddressViewCellModel alloc]init];
        addressModel.cellClass    = [DeliveryAddressViewCell class];
        addressModel.cellIdentifier     = @"DeliveryAddressViewCell";
        [self.items addObject:addressModel];
        
        SeparateModel *model13 = [[SeparateModel alloc]init];
        model13.cellIdentifier = @"sparatemodel";
        model13.cellClass = [SeparateCell class];
        [self.items addObject:model13];
        
        //商品信息
        for (ProductOutline *product in self.orderDetail.proudcts) {
            product.cellIdentifier = @"OrderDetailProductViewCell";
            product.cellClass = [OrderDetailProductViewCell class];
            [self.items addObject:product];
        }
    
        SeparateModel *model3 = [[SeparateModel alloc]init];
        model3.cellIdentifier = @"sparatemodel";
        model3.cellClass = [SeparateCell class];
        [self.items addObject:model3];
        
        PromptModel *model5 = [[PromptModel alloc]init];
        model5.cellIdentifier     = @"PromptViewCell";
        model5.cellClass    = [PromptViewCell class];
        model5.promptString = @"预约配送";
        model5.valueString  = @"2017.01.23 09:30 -10:30";
        model5.cellHeight   = @(45);
        [self.items addObject:model5];
        
        PromptModel *model6 = [[PromptModel alloc]init];
        model6.cellIdentifier     = @"PromptViewCell";
        model6.cellClass    = [PromptViewCell class];
        model6.promptString = @"下单时间";
        model6.valueString  = @"2017.01.23 09:30";
        model6.cellHeight   = @(45);
        [self.items addObject:model6];
        
        SeparateModel *model7 = [[SeparateModel alloc]init];
        model7.cellIdentifier = @"sparatemodel";
        model7.cellClass = [SeparateCell class];
        [self.items addObject:model7];
        
        PromptModel *model8 = [[PromptModel alloc]init];
        model8.cellIdentifier     = @"PromptViewCell";
        model8.cellClass    = [PromptViewCell class];
        model8.promptString = @"运费";
        model8.valueString  = @"￥0.0";
        model8.hideLineView = YES;
        model8.cellHeight   = @(25);
        [self.items addObject:model8];
        
        PromptModel *model9 = [[PromptModel alloc]init];
        model9.cellIdentifier     = @"PromptViewCell";
        model9.cellClass    = [PromptViewCell class];
        model9.promptString = @"实付款(含运费)";
        model9.valueString  = @"￥258.00";
        model9.hideLineView = YES;
        model9.valueColor   = [UIColor orangeColor];
        model9.cellHeight   = @(25);
        [self.items addObject:model9];
        
        SeparateModel *model11 = [[SeparateModel alloc]init];
        model11.cellIdentifier = @"sparatemodel";
        model11.cellClass = [SeparateCell class];
        [self.items addObject:model11];
        
        
        PromptModel *model10 = [[PromptModel alloc]init];
        model10.cellClass    = [OrderDetailActionViewCell class];
        model10.cellIdentifier     = @"OrderDetailActionViewCell";
        [self.items addObject:model10];
    }
}

#pragma mark OrderMangerDelegate
-(void)loadDataSuccessful:(OrderManager *)manager dataType:(OrderManagerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    if ([data isKindOfClass:[OrderDetail class]]) {
        self.orderDetail = data;
        if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
            [self.delegate dataConstructor:self didFinishLoad:data];
        }
    }
}

-(void)loadDataFailed:(OrderManager *)manager dataType:(OrderManagerType )dataType error:(NSError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}
@end
