//
//  CartMananger.h
//  YHClouds
//
//  Created by 黄小雪 on 15/10/23.
//  Copyright © 2015年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartModelDefine.h"

@class ShopcartManager;

@protocol ShopcartManagerDelegate <NSObject>
@required

/**
 *  当加载数据中的某一个请求成功时候的回调
 *
 *  @param manager
 *  @param dataType 加载的数据类型
 *  @param data     数据
 *  @param isCache  是否是缓存，返回的数据中只要有一条是新数据，则为NO
 */
-(void)loadDataSuccessful:(ShopcartManager *)manager dataType:(CartDataAPIType)dataType  data:(id)data  isCache:(BOOL)isCache;


/**
 *当加载数据中的某一个请求失败时候的回调，目前当有一个请求失败后不会再后续请求
 *@param manager
 *@param dataType 加载的数据类型
 *@param error 错误信息
 */
-(void)loadDataFailed:(ShopcartManager*)manager dataType:(CartDataAPIType)dataType error:(NSError*)error;

@end

@interface ShopcartManager : NSObject
@property (nonatomic,weak) id<ShopcartManagerDelegate> delegate;

/**
 *  同步购物车（如果本地有快照先上传本地快照，然后获取到最新的数据)
 *
 *  @param produtctArr 本地快照
 *  @param storeid     当前门店id
 */
-(void)refreshCart;


@end
