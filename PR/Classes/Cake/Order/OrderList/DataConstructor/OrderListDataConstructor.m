//
//  OrderListDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/7/4.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "OrderListDataConstructor.h"
#import "OrderManager.h"
#import "OrderListModel.h"
#import "ProductViewCell.h"
#import "OrderDetail.h"
#import "ProductOutline.h"

#import "OrderListActionViewCell.h"
#import "OrderListSubtotalViewCell.h"
#import "OrderListShopViewCell.h"
#import "ProductViewCell.h"
#import "SeparateCell.h"


@interface OrderListDataConstructor()<OrderMangerDelegate>
@property (strong,nonatomic) OrderManager   *manager;
@property (strong,nonatomic) OrderListModel *orderList;
@end

@implementation OrderListDataConstructor
-(void)loadData
{
    [self.manager getOrderListFirstPage];
}

- (void)loadMoreData
{
    [self.manager getOrderListNextPage];
}

-(BOOL)haveMore
{
    return self.orderList.hasMore;
}

-(void)constructData
{
    if (self.orderList) {
        [self.items removeAllObjects];
        NSArray *tDataArray = self.orderList.items;
        for (OrderDetail *orderDetail in tDataArray) {
            //分割cell
            SeparateModel *separateModel = [[SeparateModel alloc]init];
            separateModel.cellClass      = [SeparateCell class];
            separateModel.cellIdentifier = @"SeparateCell";
            [self.items addObject:separateModel];
            
            //店铺信息
            if (orderDetail.shopInfo) {
                ShopDescInfo *shopInfo = orderDetail.shopInfo;
                shopInfo.cellClass     = [OrderListShopViewCell class];
                shopInfo.cellIdentifier = @"OrderListShopViewCell";
                [self.items addObject:shopInfo];
                
                //商品信息
                NSArray *products = orderDetail.proudcts;
                if (products && [products count]) {
                    for (ProductOutline *proudct in products) {
                        proudct.cellClass     = [ProductViewCell class];
                        proudct.cellIdentifier = @"ProductViewCell";
                        [self.items addObject:proudct];
                        
                    }
                }
                
                //小计
                OrderListSubtotalViewCellModel *subTotalModel = [[OrderListSubtotalViewCellModel alloc]init];
                subTotalModel.cellIdentifier = @"OrderListSubtotalViewCell";
                subTotalModel.cellClass      = [OrderListSubtotalViewCell class];
                [self.items addObject:subTotalModel];
                
                //actionview
                OrderListActionViewCellModel *actionModel = [[OrderListActionViewCellModel alloc]init];
                actionModel.cellIdentifier = @"OrderListActionViewCell";
                actionModel.cellClass      = [OrderListActionViewCell class];
                [self.items addObject:actionModel];
            }
        }
        
    }
}


-(OrderManager *)manager
{
    if (!_manager) {
        _manager = [[OrderManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

-(void)loadDataSuccessful:(OrderManager *)manager dataType:(OrderManagerType)dataType  data:(id)data  isCache:(BOOL)isCache
{
    if ([data isKindOfClass:[OrderListModel class]]) {
        self.orderList = data;
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
