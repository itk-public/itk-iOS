//
//  ShopHomeDataConstructor.m
//  PR
//
//  Created by 黄小雪 on 2017/6/9.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "ShopHomeDataConstructor.h"
#import "ShopHomeManager.h"
#import "ShopHomeDetailInfo.h"
#import "ShopHomeCouponCell.h"
#import "ShopHomeProductCell.h"

@interface ShopHomeDataConstructor()<ShopHomeManagerDelegate>
@property (strong,nonatomic) ShopHomeManager *manager;
@property (strong,nonatomic) ShopHomeDetailInfo *detailInfo;

@end

@implementation ShopHomeDataConstructor
-(void)loadData
{
    [self.manager shopHomeInfo];
}

-(void)constructData
{
    if (self.detailInfo) {
        [self.items removeAllObjects];
        if (self.detailInfo.coupons && [self.detailInfo.coupons count]) {
            ShopHomeCouponCellModel *couponCellModel = [[ShopHomeCouponCellModel alloc]init];
            couponCellModel.coupons = self.detailInfo.coupons;
            couponCellModel.cellClass = [ShopHomeCouponCell class];
            couponCellModel.cellIdentifier = @"ShopHomeCouponCell";
            [self.items addObject:couponCellModel];
        }
        if (self.detailInfo.products && [self.detailInfo.products count]) {
            ShopHomeProductCellModel *cellModel = nil;
            NSInteger index = 0;
            for (ProductOutline *product in self.detailInfo.products) {
                if ([product isKindOfClass:[ProductOutline class]]) {
                    if (index%2 == 0) {
                        cellModel = [[ShopHomeProductCellModel alloc]init];
                        cellModel.cellClass = [ShopHomeProductCell class];
                        cellModel.cellIdentifier = @"ShopHomeProductCell";
                    }
                    [cellModel.products safeAddObject:product];
                    if (index%2 == 1 || index + 1 == [self.detailInfo.products count]) {
                        [self.items addObject:cellModel];
                    }
                    index ++;
                }
            }
        }
    }
}


-(ShopHomeManager *)manager
{
    if (_manager == nil) {
        _manager = [[ShopHomeManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

#pragma mark ShopHomeManagerDelegate
-(void)loadDataSuccessful:(ShopHomeManager *)manager  data:(id)data  isCache:(BOOL)isCache
{
    if ([data isKindOfClass:[ShopHomeDetailInfo class]]) {
        self.detailInfo = data;
        if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructor:didFinishLoad:)]) {
            [self.delegate dataConstructor:self didFinishLoad:data];
        }
    }
}

-(void)loadDataFailed:(ShopHomeManager *)manager error:(NSError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataConstructorDidFailLoadData:withError:)]) {
        [self.delegate dataConstructorDidFailLoadData:self withError:error];
    }
}
@end
