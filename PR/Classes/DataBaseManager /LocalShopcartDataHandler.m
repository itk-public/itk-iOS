//
//  LocalShopcartDataHandler.m
//  PR
//
//  Created by 黄小雪 on 2017/4/29.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import "LocalShopcartDataHandler.h"
#import "DataBaseManager.h"

@interface LocalShopcartDataHandler()
@property (strong,nonatomic) DataBaseManager *dataBaseManager;

@end
@implementation LocalShopcartDataHandler
IMP_SINGLETON;

#pragma mark public method
-(BOOL)updateProductWithProductId:(NSString *)productId
                              num:(NSInteger)num
                       isSelected:(BOOL)isSelected
                           shopId:(NSString *)shopId
                        extraInfo:(NSDictionary *)extraInfo
{
    CONDITION_CHECK_RETURN_VAULE([productId length] && [shopId length] && num, NO);
    NSDictionary *dict = @{kPidKey:productId,kNumKey:@(num),kIsSelectedKey:@(isSelected),kShopIdKey:shopId};
    CartShopDataBaseModel *dataBaseModel = [CartShopDataBaseModel modelFromDictionary:dict];
    if ([self isExistCartShopDataBaseModel:dataBaseModel]) {
        return [self.dataBaseManager updateCartShopDataBaseModel:dataBaseModel];
    }
    return [self.dataBaseManager insertCartShopDataBaseModel:dataBaseModel];
}

-(BOOL)updateProductWithProductId:(NSString *)productId
                         deltaNum:(NSInteger)deltaNum
                       isIncrease:(BOOL)isIncrease
                           shopId:(NSString *)shopId
                        extraInfo:(NSDictionary *)extraInfo
{
    CONDITION_CHECK_RETURN_VAULE([productId length] && [shopId length] && deltaNum, NO);
    NSDictionary *dict = @{kPidKey:productId,kShopIdKey:shopId};
    CartShopDataBaseModel *dataBaseModel = [self.dataBaseManager queryCartShopDataBaseModel:[CartShopDataBaseModel modelFromDictionary:dict]];
    NSInteger num  = 1;
    if (dataBaseModel) {
        NSInteger lastNum = dataBaseModel.num;
        if (isIncrease) {
            num = lastNum + deltaNum;
        }else{
            num = lastNum - deltaNum;
        }
    }
    return [self updateProductWithProductId:productId num:num isSelected:YES shopId:shopId extraInfo:extraInfo];
}

-(BOOL)deleteProductWithProductId:(NSString *)productId
                           shopId:(NSString *)shopId
{
    CONDITION_CHECK_RETURN_VAULE([productId length] && [shopId length], NO);
    NSDictionary *dict = @{kPidKey:productId,kShopIdKey:shopId};
    CartShopDataBaseModel *dataBaseModel = [CartShopDataBaseModel modelFromDictionary:dict];
    return [self.dataBaseManager deleteCartShopDataBaseModel:dataBaseModel];
}

-(BOOL)deleteAllProducts
{
    return [self.dataBaseManager deleteAllProducts];
}
-(NSInteger)productNumWithProductId:(NSString *)productId
                             shopId:(NSString *)shopId
{
    CONDITION_CHECK_RETURN_VAULE([productId length] && [shopId length], NO);
    NSDictionary *dict = @{kPidKey:productId,kShopIdKey:shopId};
    CartShopDataBaseModel *dataBaseModel = [self.dataBaseManager queryCartShopDataBaseModel:[CartShopDataBaseModel modelFromDictionary:dict]];
    if (dataBaseModel) {
        return dataBaseModel.num;
    }
    return 0;
}

#pragma mark 懒加载
-(DataBaseManager *)dataBaseManager
{
    if (!_dataBaseManager) {
        _dataBaseManager = [DataBaseManager sharedDataBaseManager];
    }
    return _dataBaseManager;
}

#pragma mark private method
-(BOOL)isExistCartShopDataBaseModel:(CartShopDataBaseModel *)cartShopDataBaseModel
{
    if ([self.dataBaseManager queryCartShopDataBaseModel:cartShopDataBaseModel]) {
        return YES;
    }
    return NO;
}

@end
