//
//  ShopcartFormat.h
//  YHClouds
//
//  Created by 黄小雪 on 2017/4/26.
//  Copyright © 2017年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString * kToCommitStoridKey;
FOUNDATION_EXTERN NSString * kToCommitSelleridKey;
@class ShopcartFormat;

typedef void (^ShopcartFormatReloadTableViewBlock)();

typedef NS_ENUM(NSInteger,ShopcartFormatDataType)
{
    ShopcartFormatDataTypeFreshen  = 0,   //刷新购物车
    ShopcartFormatDataTypeCommit,         //去结算
};


@protocol ShopcartFormatDelegate <NSObject>
-(void)loadDataSuccessful:(ShopcartFormat *)shopcartFormat
                 dataType:(ShopcartFormatDataType)dataType
                     data:(id)data
                extraInfo:(NSDictionary *)extraInfo;

-(void)loadDataFailed:(ShopcartFormat *)shopcartFormat
             dataType:(ShopcartFormatDataType)dataType
                error:(NSError*)error;

@end

@interface ShopcartFormat : NSObject
@property (weak,nonatomic) id<ShopcartFormatDelegate> delegate;
@property (copy,nonatomic) ShopcartFormatReloadTableViewBlock reloadTableViewBlock;

//勾选商品
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;
//商家的全选或非全选操作
- (void)selectSellerAtSection:(NSInteger)section isSelected:(BOOL)isSelected;
//修改个数
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
//删除一个商品
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath;
//点击编辑
- (void)editSellerAtSection:(NSInteger)section isEdit:(BOOL)isEdit;
//删除商家下的所有选中商品
- (void)deleteSellerProductAtSection:(NSInteger)section;
//结算
- (void)commitSellerProductAtSection:(NSInteger)section;
//请求购物车的数据源
- (void)requestShopcartProductList;

@end
