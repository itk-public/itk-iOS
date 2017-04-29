//
//  APIInteractCenter.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIRespondAuth.h"


@class APIInteractCenter;
@interface APIInteractCenter : NSObject
DEF_SINGLETON(APIInteractCenter)

//interact progess control
// interact progerss control
- (void)registerAPICall:(NSString *)identify interactor:(id)interactor;

- (void)cancelAPICall:(NSString *)identify interactor:(id)interactor;

- (void)cancelAllIdentifyAPICall:(NSString *)identify;

- (void)finishAPICall:(NSString *)identify interactor:(id)interactor;

- (BOOL)checkAPIIncall:(NSString *)identify;

/**
 *  验证是否需要进行数据清理
 *
 *  @param respondData 返回的数据
 *  @param interactor  发起的API对象
 *
 *  @return 是否需要进行阻塞清理
 */
- (BOOL)cleanRespondData:(BaseRespond *)respondData inAPI:(id)interactor;


- (APIRespondAuth *)authObj;

@end
