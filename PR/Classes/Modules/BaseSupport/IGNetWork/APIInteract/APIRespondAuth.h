//
//  APIRespondAuth.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPIInteract.h"
#import "IGNetwork.h"

typedef void(^AuthNotifyRetryBlock)(void);
typedef void(^AuthNotifyContinueBlock)(void);

@interface APIRespondAuth : NSObject

/**
 *  验证返回的数据是否需要进行Token 验证
 *
 *  @param respondData 服务端数据
 *  @param interactor  发起请求的 interact 对象
 *
 *  @return YES,需要进行异步认证
 *          NO,不需要认证
 */

-(BOOL)verifyAuth:(BaseRespond *)respondData inAPI:(id)intercator;

-(BOOL)verifyAuth:(BaseRespond *)respondData
   withRetryBlock:(AuthNotifyRetryBlock)retryBlock
    continueBlock:(AuthNotifyContinueBlock)continueblock;

- (void)refreshWithBlock:(AuthNotifyRetryBlock)retryBlock
                        :(AuthNotifyContinueBlock)continueblock;
@end

@interface APIRespondAuth(shareObj)
/**
 *  获取共有的认证对象
 *
 *  @return APIRespondAuth 对象
 */
+ (instancetype)defaultAuth;

/**
 *  启动一次刷新refreshtoken 流程
 */
- (void)doRefreshToken;
@end

