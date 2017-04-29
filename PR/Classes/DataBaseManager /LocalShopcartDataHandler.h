//
//  LocalShopcartDataHandler.h
//  PR
//
//  Created by 黄小雪 on 2017/4/29.
//  Copyright © 2017年 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LocalShopcartDataHandler : NSObject
DEF_SINGLETON(LocalShopcartDataHandler)

/**
 *  更新商品
 *
 *  @param productId         商品id
 *  @param num               商品个数
 *  @param selectstate       商品选中状态
 *  @param merid             店铺id
 *  @param extraInfo         附加信息，可空
 *  @return 是否更新成功
 */
-(BOOL)updateProductWithProductId:(NSString *)productId
                              num:(NSInteger)num
                       isSelected:(BOOL)isSelected
                           shopId:(NSString *)shopId
                        extraInfo:(NSDictionary *)extraInfo;


/**
 *  更新商品根据增量
 *
 *  @param productId         商品id
 *  @param deltaNum          增量
 *  @param isIncrease        是否是增加
 *  @param merid             店铺id
 *  @param extraInfo         附加信息，可空
 *  @return 是否更新成功
 */
-(BOOL)updateProductWithProductId:(NSString *)productId
                         deltaNum:(NSInteger)deltaNum
                       isIncrease:(BOOL)isIncrease
                           shopId:(NSString *)shopId
                        extraInfo:(NSDictionary *)extraInfo;


//删除一个商品
-(BOOL)deleteProductWithProductId:(NSString *)productId
                           shopId:(NSString *)shopId;
//删除所有的商品
-(BOOL)deleteAllProducts;

//商品个数
-(NSInteger)productNumWithProductId:(NSString *)productId
                             shopId:(NSString *)shopId;
@end
